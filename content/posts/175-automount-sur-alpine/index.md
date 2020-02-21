+++
Author = "Lord"
Description = "Un petit tuto pour trifouiller une Alpine Linux afin d'automonter les partitions des disques durs sata et usb. Il faut éditer un peu mdev pour arriver à un bon résultat. On est tipar !"
Categories = ["alpine", "linux", "busybox","adminsys"]
menu = "main"
notoc = true
PublishDate = 2019-08-03T18:22:31+02:00
date = 2019-08-07T16:22:31+02:00
title = "Automount des partitions par leur label sous Alpine avec mdev"
editor = "kakoune"
TopWords = [  "storage_dir", "disk", "label", "target_symlink", "mount", "partition", "mdev"]
+++
Bon maintenant que j'ai une Alpine sur l'Odroid HC2 il faut y mettre les données.
J'ai donc un bon gros disque dur sur le port sata et un dock USB pour le disque dur des backup.

Pas de bol, les disques apparaissent bien dans */dev/sdXy* sauf que j'ai par habitude de ne pas monter les partitions avec leur nom de device mais par un label, ou un uuid ou juste un id.
Pas de bol, là, je n'ai qu'un id qui apparait dans */dev/disk/by-\** .

## Lister les devices
Comment ça marche ce truc d'ailleurs ?

Le kernel est pas très dégourdi : il ne gère pas la partition */dev*, lui se contente de générer */sys* qui contient tous les devices mais en vrac.
À chaque fois que le kernel détecte un mouvement côté device, il va lancer une commande dans le userspace.
Il est d'ailleurs possible de changer cette commande pour mettre ce que vous voulez.
Dans le cas d'Alpine, on utilise *Busybox* et donc **mdev** au lieu de *udev*.
On peut voir quelle est la commande en faisant un <samp>*cat /proc/sys/kernel/hotplug*</samp>
Dans notre cas particulier, il faudra y trouver */sbin/mdev* .

Là **mdev** va voir l'arrivée/départ du device et va agir en fonction de sa conf qui est définie dans */etc/mdev.conf* .
Ce fichier a une syntaxe au final assez simple définissant, en fonction du type de device, quel fichier créer dans */dev* avec quels droits et éventuellement quelle commande lancer.
Si vous voulez plus d'infos sur ce sujet il existe [un article sympa pour débuter avec mdev (en anglais)](https://git.busybox.net/busybox/tree/docs/mdev.txt?h=1_18_stable).

Bref, dans notre cas on va lancer un script dont le boulot va être de reconnaître le disque dur, puis ses partitions et ensuite de les mount.
Donc on édite <details open><summary>/etc/mdev.conf</summary>
{{< highlight bash >}}
#sd[a-z].*	root:disk 0660 */lib/mdev/usbdisk_link
sd[a-z].*	root:disk 0660 */sbin/automount.sh
{{< / highlight >}}
</details>

Voilà, on commente la ligne d'origine qu'on remplace par la nouvelle servant à lancer */sbin/automount.sh*

Bon pour ce script on peut le faire soi-même ou bien faire confiance à Piotr Karbowski qui nous a pondu un script excellent que vous trouverez [dans son repo github](https://raw.githubusercontent.com/slashbeast/mdev-like-a-boss/master/helpers/storage-device).
Il ne manque qu'un ptit truc à ce script, l'automount.
En fait il se contente de peupler les */dev/disk/by-\**.

J'ai donc juste ajouté une ligne.
<details><summary>/sbin/automount.sh</summary>
{{< highlight bash "hl_lines=89" >}}
#!/bin/sh
# Copyright (c) 2012, Piotr Karbowski <piotr.karbowski@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
#
#    * Redistributions of source code must retain the above copyright notice, this list
#      of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright notice, this list
#      of conditions and the following disclaimer in the documentation and/or other
#      materials provided with the distribution.
#    * Neither the name of the Piotr Karbowski nor the names of its contributors may be
#      used to endorse or promote products derived from this software without specific
#      prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
# THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE US
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This script meant to create /dev/disk/by-* and /dev/mapper/* symlinks.
# and remove them after storage device is removed.
# the /dev/disk/by-* handling based on the idea and proof of concept from BitJam.

# debug
#exec >> /run/debug-mdev 2>&1
#set -x
#echo '### ENV:'
#env
#echo '### CODE:'
#

umask 077

storage_dir="/dev/.mdev-like-a-boss"
[ -d "${storage_dir}" ] || mkdir "${storage_dir}"

[ "${MDEV}" ] || exit 2

create_uuid_label_symlink() {
	local target_dir="/dev/disk/by-${1}"
	local target_symlink="${target_dir}/${2}"
	[ -e "${target_symlink}" ] && return
	mkdir -p "${target_dir}"
	ln -snf "/dev/${MDEV}" "${target_symlink}"
	echo "${target_symlink}" >"${storage_dir}/storage_symlink_${1}_${MDEV}"
}

add_symlinks() {
	# Skip temp cryptsetup nodes.
	case "${MDEV}" in
		'dm-'[0-9]*)
			case "$(cat "/sys/block/${MDEV}/dm/name")" in
				'temporary-cryptsetup-'[0-9]*)
					return 0
				;;
			esac
		;;
	esac

	if command -v blkid >/dev/null 2>&1; then
		local field name value UUID LABEL TYPE PTTYPE PARTLABEL PARTUUID
		local blkid_output="$(blkid "/dev/${MDEV}")"
		eval "${blkid_output#*: }"

		[ "${UUID}" ] && create_uuid_label_symlink 'uuid' "${UUID}"
		[ "${LABEL}" ] && create_uuid_label_symlink 'label' "${LABEL}"
	fi

	if [ -f "/sys/block/${MDEV}/dm/name" ]; then
		[ -d '/dev/mapper' ] || mkdir '/dev/mapper'
		if ! [ -c '/dev/mapper/control' ]; then
			awk '$2 == "device-mapper" { foo = system("mknod /dev/mapper/control c 10 " $1); exit foo }' /proc/misc || exit 1
		fi
		local dmname="$(cat "/sys/block/${MDEV}/dm/name")"
		if [ "${dmname}" ]; then
			local target_symlink="/dev/mapper/${dmname}"
			[ -e "${target_symlink}" ] && return
			ln -snf "/dev/${MDEV}" "${target_symlink}"
			echo "${target_symlink}" >"${storage_dir}/storage_symlink_mapper_${MDEV}"
		fi
	fi
	mount -a
}

drop_symlinks() {
	local type
	for type in uuid label mapper; do
		[ -f "${storage_dir}/storage_symlink_${type}_${MDEV}" ] || continue
		local target_symlink="$(cat "${storage_dir}/storage_symlink_${type}_${MDEV}" 2>/dev/null)"
		[ "${target_symlink}" ] || continue

		local target_symlink_device="$(readlink "${target_symlink}")"
		if [ "${target_symlink_device}" = "/dev/${MDEV}" ]; then
			rm "${target_symlink}"
		fi
		rm "${storage_dir}/storage_symlink_${type}_${MDEV}"
	done
}

case "${ACTION}" in
	'add'|'')
		add_symlinks
	;;
	'remove')
		drop_symlinks
	;;
esac
{{< / highlight >}}
</details>

## Automount
C'est presque tout bon : on a donc les disques qui apparaissent bien dans */dev/disk/by-\** et on les monte automatiquement.
Il ne reste donc plus qu'une étape pour les monter au bon endroit : *configurer /etc/fstab*

<details open><summary>/etc/fstab</summary>
{{< highlight bash >}}
/dev/disk/by-label/morty	/mnt/sata	ext4	auto,noatime 0 0
/dev/disk/by-label/backup	/mnt/usb	btrfs	auto,noatime 0 0
{{< / highlight >}}
</details>

## Définir les labels
Bon c'est cool mais est-ce que vos disques ont bien leur label ?

### Ext4
Un simple <samp>*tune2fs -L backup /dev/sdb1*</samp>

### Btrfs
Tout aussi simple <samp>*btrfs filesystem label /dev/sda1 backup*</samp> et c'est bon.

## Un reboot et c'est tout bon !
Si tout s'est bien passé vous avez vos disques montés au bon endroit et tout ce qu'il faut comme il faut.

*C'est un peu dommage qu'Alpine ne fournisse pas un script mieux foutu pour l'apparition des devices mais bon c'est l'avantage d'une distro minimaliste : il y a peu de morceaux à devoir décortiquer/analyser/comprendre pour pouvoir trifouiller et arriver au résultat escompté.


