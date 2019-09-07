+++
Author = "Lord"
Description = "Beaucoup de chats d'appartements sont mal nourris ce qui cause de nombreuses maladies chez les greffiers. Il est important pour leur santé de faire attention à ce qu'on leur donne à bouffer et de ne pas se contenter de la merde qu'on trouve partout."
Categories = ["chat", "nanimo"]
menu = "main"
notoc = true
PublishDate = 2019-07-15T12:19:21+02:00
date = 2019-07-15T12:19:21+02:00
title = "Nourrir ses gentils ptits chats"
editor = "kakoune"
+++

J'ai envie de vous parler de chat.
Pas de discussion, hein.
De chats.
Les espèces de parasites qui dorment et réclament à manger.

J'en discute parfois avec des amis eux aussi infectés et il s'avère que depuis quelques mois j'ai pris conscience à quel point on nourrissait mal nos ptits bestiaux.
Beaucoup de chats d'appartements sont en surpoids.
Il faut dire que certains chats gourmands réclameront constamment de la nourriture et ne s'arrêteront que lorsque la gamelle est bien vide.

Mais pire que ça, *souvent le régime alimentaire est désastreux*.
La très grande majorité de la bouffe pour animaux trouvée en supermarché ou magasins spécialisés n'est en fait pas vraiment approprié aux besoins réels des chats.
Et ça inclut également la bouffe “premium” qui est juste plus chère que la classique sans forcément être meilleure.
Les croquettes et pâtées sont souvent remplies de céréales, ce que les chats ne devraient pas manger.

Et la bouffe vendue par les vétos c'est souvent le même topo.
Ils sont sponsorisés par Purina ou Hills ou autre truc du genre qui sont premium avec souvent telle ou telle vertue mais qui sont quand même blindée de céréales avec un fort taux de glucose et compagnie.
Bref ne cédez pas.

Cette bouffe est souvent cause de divers problèmes dont l'obésité premièrement mais surtout du diabète.
Bref, regardez un peu la composition de ce que vous leur donnez (ne vous arrêtez pas à l'étiquettes "truc au thon", "truc au poulet", mais regardez les proportions).
Vous pouvez vous renseigner sur le web pour trouver plus d'infos à ce sujet, vous trouverez des documentaires des sites qui publient des comparatifs détaillées de la composition des croquettes.

## Les forces en présences
Personnellement cela fait maintenant deux ans qu'on a radicalement changé l'alimentation de nos bestiaux.
Ma ménagerie actuelle se compose d'un gros mâle de 9.6Kg, une petite femelle de 4.5Kg et d'une seconde femelle de 6.3Kg.

Le but du jeu a été de faire perdre 2Kg au gros, et 1Kg à la seconde femelle.
Auparavant, on ne les nourrissait uniquement de croquettes qui étaient dispo à volonté.
À peine la gamelle était un peu trop vide, le mâle nous le faisait savoir.

## Un nouveau régime
Malheureusement avec l'âge et le surpoids, le gros a commencé à boiter et suite à un voyage chez la véto, le verdict est tombé : *arthrose + obésité*.
Du coup, on s'est pas mal renseigné et c'est parti pour un changement drastique d'alimentation.

Exit les croquettes de merde.
On va changer ça par quelque chose de plus sain.

Je ne vous cache pas qu'on a tâtonné quelque temps avant d'arriver de trouver la bonne formule avec les bonnes quantités.
On a commencé par utiliser des croquettes de régime achetées en animalerie.

Effectivement ça marchait bien, le chat perdait du poids et ne réclamait pas, mais il n'avait vraiment pas la forme, son poil devenait terne… bref il dépérissait au bout de deux mois…

Bref après quelques errements la formule est désormais toute simple.
**On passe à un mélange de pâtée le soir à heure fixe et un peu de croquettes durant la journée.**
Niveau pâtée on donne des ptites boîte de marque *Cosma*.
Ça revient à **environ 1€ la boîte journalière pour les trois chats**.

Il y a plusieurs parfums et ça a l'air presque appétissant (sur un toast ça passerait probablement).
Une petite boîte répartie équitablement (la répartition est équitable, par contre le gros s'arrange toujours pour finir à droite à gauche) entre les trois.
Et surtout à heure fixe : une fois l'habitude prise, ils sauront vous le rappeler au bon moment, plus besoin de rappel.

Et pour les croquettes on a pris du *Orijen 6fish* pendant un temps mais nous sommes passé à du *Purizon Adult Sterilized Chicken & Fish*.
On est **autour de 45€ le paquet de 6.5Kg** qui tient un mois et demi pour les trois, en mettant quatre à cinq fois dans la journée de toutes petites ration dans la gamelle quand ils réclament.

## Niveau prix
Attention voilà la douloureuse : On est à environ **68€/mois** en incluant également la litière.

Bon d'ailleurs, soit-dit en passant, niveau litière on a arrêté la litière pourrie qui pu constamment.
On est passé à une litière végétale qui absorbe incroyablement bien les odeurs et qui s'agglomère bien et qui est biodégradable (on ose pas les foutre dans le compost pour autant).
C'est la *Cat's best öko plus* à près de 26€ les 40L.
Ça tient deux mois sans soucis pour les trois chats.
C'est le jour et la nuit avec la litière Catsan qui empeste la pisse au bout de deux jours.

Bref c'est un budget assez conséquent mais au moins ils mangent pas de la merde et se portent bien mieux.

## Verdict

<script src="jquery-3.1.1.min.js"></script>
<script src="highstock.js"></script>
<script type="text/javascript" src="data.js"></script>
<script type="text/javascript" src="dark-unica.js"></script>

<script type="text/javascript">
$(document).ready(function() {

$.get('poids.csv', function(csv) {
				$('#poids').highcharts({
					chart: {
						type: 'spline',
						zoomType: 'x'
					},
					data: {
						csv: csv,
						dateFormat: 'dd/mm/YY',
					},
					title: {
						text: "Les progrès du monstre"
					},
					xAxis: {
						type: 'datetime',
						plotBands: [{
							from: Date.UTC(2017,04,09),
							to: Date.UTC(2017,07,31),
							color: '#222211',
							label: {
								text: '<em>Croquettes régime</em>',
								style: {
									color: '#ccc'
									},
							}
						},{
							from: Date.UTC(2017,07,31),
							to: Date.UTC(2018,05,01),
							color: '#112222',
							label: {
								text: '<em>Croquettes premium</em>',
								style: {
									color: '#ccc'
								}
							}
						},{
							from: Date.UTC(2018,05,01),
							to: Date.UTC(2019,03,18),
							color: '#221122',
							label: {
								text: '<em>Bonnes croquettes</em>',
								style: {
									color: '#ccc'
								}
							}
						},{
							from: Date.UTC(2019,03,18),
							to: Date.UTC(2025,06,11),
							color: '#122112',
							label: {
								text: '<em>Bon régime</em>',
								style: {
									color: '#cdc',
								}
							}
						}]
					},
					yAxis: {
						title: {
							text: 'Poids (Kg)'
						},
						/*type: 'logarithmic',
						minorTickInterval: 1*/
					},
					tooltip: {
						shared: true,
						crosshairs: true
					},plotOptions: {
						series: {
							connectNulls: true
						},
						spline: {
							marker: {
								enabled: true,
								radius: 2
							}
						}
					},
			    });



			});
			});
</script>

<div id="poids" style="width:100%; height: 600px;"></div>
Sur le graph on voit la période de Mai à Aout 2017 avec les croquettes de régime qui l'ont mis dans un sale état.

Ensuite on est passé à des croquette "premium" jusqu'à Mai 2018 où la prise de poids a été constante.

De juillet 2018 à Avril 2019, c'était le régime avec les nouvelles croquettes sans pâtée.
Il y a cependant quelques défaut sur le graph : le pic de Décembre est dû à un premier soucis de balance.
Le pic d'Avril est dû au changement de balance (en vrai il n'a pas pris de poids, c'est juste que la nouvelle est mieux tarée).

Et enfin à partir d'Avril 2019 le mix pâtée + croquettes.

On va pas se le cacher ça coûte plus cher qu'avant mais en contrepartie, les chats ont un régime vraiment meilleur qu'avant.
On ne risque plus trop de leur infliger un diabète ou tout un tas de maladie perrave.

Par trop de risque rénaux du fait de l'alternance pâtée et croquettes.

Et en trois mois, **le gros est passé de 9.6Kg à 8.3Kg** sans avoir l'air de dépérir.
Ils réclament bien moins à manger et sont en bonne santé.

Bref pourvu que ça dure !
Je vous referai un point dans quelques mois quand il aura stabilisé son poids.
