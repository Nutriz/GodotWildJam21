# Connect In People

**You will literally connect people between them, but can you do more ?**

## L'histoire

You are Bernadette, a young woman working in telecomunication. Your work is to connect jacks on a Telephone switchboard all the day long.
To pass time, you try to help customers to reconnect them together...

## Le jeu

* Message du jeu: l'importance de rapprocher les gens, les connecter. Le plaisir d'aider les gens.
* Challenge du jeu: Trouver et mémoriser le bon interlocuteur
* Condition d’échec: trop de mauvaises liaisons avec mauvais interlocuteur, l'histoire se finie mal
* Condition de réussite: majoritairement de bonnes connexion, l'histoire se finie bien
* Motivation à jouer: Le joueur veut connaitre la fin de l'historie (il faudra installer une intrigue en début de jeu)

## Boucle de jeu (gameplay)

* Objectif: Connecter l'appelant au bon destinataire
* Challenge: déduire le destinataire et/ou faire appel à sa mémoire
* Récompense: bon destinataire, l'histoire continue
* Sanction: mauvais destinataire, l'histoire stagne. Pour adoucir l'échec, trouver des choses rigolotes quand mauvais interlocuteur

### Boucle de jeu détaillée:

* Un appel entrant apparait sur le standard téléphonique
* Saisir son jack (le jack du joueur)
* Le brancher dans le jack de l'appelant
* Ecouter l'interlocuteur et en déduire le destinataire
* Mettre l'appelant en attente
* Deviner le jack destinataire où brancher
* brancher sa 2ème partie du jack au prétendu destinataire
* Ecouter la conversation et en déduire si l'appel a bien été dirigé où il fallait

## Le style

* L’ambiance: année 1920, vintage 
* Style: 2d s'approchant d'un standard téléphonique réel 
* La couleur: brun / coloré / boisé / chaude
* Le son: broua ambiant / bruits mécaniques / bruits électroniques bip bip
* La mise en scène: angle fixe en face du standard téléphonique.
	si assez de temps, afficher un environnement de travail autour, posters, soda, affaires personnelles.
* Les menus: vintage
* Effets d‘image: à définir
* Format: priorité format PC et jeu à la souris (possible de jouer dans l'explorateur), portage mobile si assez de temps

## Signes et feedback

* Faire comprendre au joueur ce qu’il doit faire et comment il peut le faire
	* effet vert/rouge sur le jack pour savoir si on peut connecter ou pas
	* si positif -> son positif, connecte je jack, conversation qui commence
	* si négatif -> son négatif, le jack retourne à sa position initial

* Signes, provoquer l'action: Jack qui clignottes pour première boucle de jeu
	
Le système de jeu, tables de loi qui régissent le jeu
* Règles: une seule connexion à la fois, 
	Limites

----

## TODO

### ✔️Etape 1: Proto

* ✔️Affichage du board
* ✔️Affichage des entreés jack
* ✔️Afficher les jacks
* ✔️Pouvoir connecter un jack avec un autre
* ✔️Dessiner le cable (utiliser une droite temporairement)
* ✔️Affichage des dialogues

### Etape 2: Production du jeu

* Ajouter un technicien qui recable certaines sorties
* ✔️Gérer la progression de l'histoire, faire des sections dans le JSON des dialogues.
* ✔️Format des dialogues pour importation dans le jeu
* ✔️Recevoir un appel entrant
* ✔️Gérer la progression de l'histoire
* ✔️Faire un joli standard téléphonique
* ✔️Intégrer quelques sons de base, indispensable au gameplay

* Tech
  * ✔️Utilise le nom des nodes pour les inputs jack ?

* Dialogues
  * ✔️Afficher le dialogue du chef en début de jeu
  * ✔️Afficher l'introduction en fullscreen
  * ✔️Pouvoir connecter les sorties et les mélanger
  * ✔️Pouvoir afficher dialogue du technicien et recâbler
  * ✔️TOOLS: debug en jeu affiche si longueur de phrase trop long
  * Afficher tag de fin à la place du next indicator

* Graphismes
  * ✔️Finir les input B
  * ✔️Encadré de dialogue en vectoriel
  * ✔️Nouveau jack (rouge et bleu) en vectoriel
  * ✔️Scale en Y du jack pour simuler l'effet d'angle
  * ✔️Shader effect année 20
  * ✔️Faire le bouton de switch en vectoriel
  * Faire la lumière pour le bouton de switch
  * Faire un câble de Jack plus réaliste.

* Sons
  * Faire la "musique" d'environnement, broua de télécomunication
  * Refaire les voix "yaourt"

* Bugs
  * ✔️Next indicator du boss au mauvais endroit
  * Tester si les actions sont bien verrouillées quand dialogue (switch on puis off avant fin de conv)

### Etape 3: Polish

* ✔️Faire un menu
* Être sûr que les instructions de tuto soient OK
* Que faire avec les shaders ?
* ✔️Afficher une led rouge à côté du jack pour dire "en ligne"
* Afficher un environnement de travail autour du standard téléphonique, posters, soda, affaires personnelles.
* Ajouter mini mouvement de caméra quand on manipule les jacks
* (bonus) Pour expliquer que les destinataires soient inconnus, en début de parti il y a un coup de vent qui fait s'envoler les post-it ayant les informations.
* (bonus) Pour coller des post-it sur les destinations.

### publication

* screenshots
* textes
* community manager stuff
