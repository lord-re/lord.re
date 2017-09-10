+++
notoc = true
menu = "main"
date = "2017-10-07T11:49:01+02:00"
PublishDate = "2017-10-07T11:49:01+02:00"
title = "Enregistrement DNS de type CAA poru protéger votre TLS"
Tags = ["adminsys","sécu"]
Categories = ["adminsys","sécu"]
Description = "Comment améliorer un chouilla sa sécurité TLS"

+++

La mouvance actuelle de chiffrer de plus en plus de contenu est vraiment une bonne chose. Un peu plus de sécurité pour tout le monde c'est parfait. Surtout si c'est bien fait sinon c'est complètement contre-productif. Letsencrypt a énormément contribué à la démocratisation des certifs x509 pour le ***TLS*** grâce à son protocole bien efficace et aussi ses tarifs imbattables.
## Certificate Transparency
Comme de nombreuses ***CA*** (Autorité de Certifacition : les organismes "de confiance" qui signent les certificats x509) désormais, Letsencrypt participe au ***Certificate Transparency***. Il s'agit d'un log publique remplie par les CA où elles annoncent tous les certificats qu'elles émettent. En gros avec ça vous ne pouvez plus prendre de certificat discrètement sans que ça ne se sâche.

Si jamais une CA sérieuse (ça veux dire à minima qu'elle participe à Certificate Transparency) créer un certificat ça, elle le publiera donc dans le log ce qui permettra donc de voir quand est-ce qu'il y a un nouveau certificat et émis par quelle CA. Avec ce système il est donc possible de savoir qu'un certificat a été émis, par quelle CA, et quand. Donc vous allez pouvoir savoir si un certificat a été émis dans votre dos.

## CAA
Le Certificate Transparency c'est donc déjà une bonne première étape mais il y a mieux ! Il est désormais possible d'indiquer quelle CA est autorisée à signer des certificats pour un domaine. Depuis Septembre 2017, les CA ont l'obligation de vérifier qu'elles sont autorisées à signer vos certificats via l'enregistrement DNS de type ***CAA***.

C'est donc dans le DNS que l'on va indiquer quelle CA peut signer vos certificats. Si elle n'est pas présente dans le CAA, une CA ne pourra pas signer des certificats. C'est donc une énorme amélioration de la sécurité.

## Mise en pratique
Bon donc dans votre zone DNS vous allez simplement ajouter ```lord.re. CAA 0 issue "letsencrypt.org"``` et hop. Seul letsencrypt peut désormais signer vos certs.

C'est tout. Si vous voulez du wildcard il faut une autre ligne : ```lord.re. CAA 0 issuewild "letsencrypt.org"``` bon c'est plutôt logique. Vous pouvez mettre plusieurs ligne CAA bien entendu si vous voulez utiliser plusieurs CA différentes.

Il est également possible de spécifier une adresse mail de contact pour être averti par la CA se faisant envoyer bouler : ```lord.re. CAA 0 iodef "mailto:truc@votrema.il"``` et zou.

## On supercharge encore plus DNS et on est toujours aussi dépendant des CA
Le DNS contient de plus en plus d'informations sensibles. On peut déjà y mettre des clés publiques SSH, on y met des hash de vos certificats et maintenant on y place également les CA avec lesquelles vous collaborez. C'est donc de plus en plus un élément sensible dans la chaîne de sécurité. ***DNSSEC*** est donc de plus en plus indispensable. Sa démocratisation est indispensable. Les registrar doivent s'adapter et les logiciels également pour prendre en compte ce protocole.

Le rôle des ***CA*** est toujours aussi central. Une CA malveillante pourrait ne pas publier certains certificats dans le log publique… Elle pourrait également ne pas prendre en compte l'enregistrement CAA… Leur rôle est toujours autant basé sur la confiance et il est de plus en plus nécessaire de pousser l'adoption de ***DANE***. Il est triste que cette norme ne gagne pas plus d'adoption générale :-(

Sur cette note de tristesse… ciao.
