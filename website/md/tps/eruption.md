# TP : Eruption solaire et transit de Mercure, à partir des données AIA SDO

!!! danger

	miroir local


<center>
![L'observation du soleil dans différentes longueurs d'ondes offrent différentes perspectives](../assets/solar_wavelength2.jpg){width=50%}
</center>

## Introduction

Le but de ce TP est de construire une vidéo à partir de données collectées sur le soleil par le [Solar Dynamics Observatory](http://aia.lmsal.com/index.htm). On utilisera uniquement les images du soleil capturées à intervalles réguliers. Les images sont disponibles à l'adresse [http://jsoc.stanford.edu/data/aia/images/](http://jsoc.stanford.edu/data/aia/images/). Elles sont classées par date de mesure, la structure du répertoire distant étant :

> http://jsoc.stanford.edu/data/aia/images/YYYY/MM/DD/$\lambda$/fichier.jp2

Le SDO observe le soleil dans différentes longueurs d’onde $\lambda \in [94, 131, 171 , 193, 211, 304, 335, 1600, 1700, 4500]$Å (angstroms). Pour avoir une idée des mesures à ces différentes longueurs d’onde, vous pouvez vous rendre à l’adresse [http://sdo.gsfc.nasa.gov/data/](http://sdo.gsfc.nasa.gov/data/), ou bien regarder l’image en haut de la page.

Durant ce TP, je vous propose d'utiliser les mesures à $211$Å. Les images sont au format JPEG2000 avec l'extension $jp2$ et une résolution de $4096 \times 4096$. Dans ce TP, on cherche à illustrer la construction de programmes du type ``puits | commande1 | commande2 ....''. On va :

- récupérer les images, 
- les convertir en JPEG, 
- les redimensionner, 
- y incruster la date et l'heure de la mesure et 
- les combiner pour construire une vidéo. 

On va voir dans ce TP l'utilisation d'un certain nombre de programmes tels que `bash`, `lynx`, `wget`, `convert` (imagemagick), `gawk`, `sed` et `ffmpeg`. On cherche ainsi à ne pas réinventer la roue, votre problème est de produire une vidéo à partir des images brutes et on va voir qu'en assemblant plusieurs briques déjà existantes, on peut facilement résoudre ce problème.

!!! warning


	**Attention**: Lors de la mise en place du TP, il peut être intéressant d'utiliser un miroir local en ne récupérant par example que les images de quelques éruptions solaires, à savoir:

	- le 07/06/2011 en $304$Å : grosse éruption entre 6h et 7h
	- le 31/08/2012 en $211$Å et $171$Å : petite éruption autour de 19h
	- le 09/05/2016, Mercure transite devant entre le soleil et la terre vers 11h30

	Il y a plusieurs raisons à l'utilisation de ce miroir local: 1) les temps d'accès, 2) je crains que si tout le monde accède de manière répétée au site jsoc.stanford.edu, nous soyons banis de leur serveur web et donc qu'on ne puisse pas faire correctement le TP, 3) on ne surcharge pas inutilement leurs serveurs pour nos TPs.

	Nous allons pour le coup utiliser un miroir local. Demandez moi l'URL ! Dans toute la suite du sujet, il faudra bien penser à remplacer jsoc.stanford.edu par l'adresse vers le serveur infomob.

## Structure du projet

Je vous propose de créer quelques répertoires pour structurer votre projet. Pour les créer, forcez-vous à utiliser les commandes `mkdir`, `ls`, etc. depuis un terminal.

- scripts : contiendra la plupart des scripts que vous écrirez,
- raw_images : contiendra de manière temporaire les images brutes au format .jp2,
- images: contiendra les images converties au format jpeg et redimensionnées,
- postproc_images: contiendra les images jpeg dans lesquelles la date et l'heure auront été incrustées
- video : contiendra les vidéos générées

La figure ci-dessous donne une vision d'ensemble du programme que nous allons écrire.

![Vue d'ensemble du pipeline de traitement des données](../assets/soleil_schema.png)

## Récupération des données d'une journée

Le but de cette partie est d'écrire un script Bash qui se charge de récupérer les images d'une journée. Ce script prendra 4 arguments, à savoir :

- l'année YYYY, 
- le mois MM, 
- le jour DD et 
- la longueur d'onde $\lambda$ des mesures. 

Il devra produire en sortie le flux des URLs des images de cette journée particulière à la longueur d'onde $\lambda$.

Si vous allez sur le site [http://jsoc.stanford.edu/data/aia/images](http://jsoc.stanford.edu/data/aia/images), et regardez les images du 31 août 2012, vous constaterez qu'il y a énormément d'images, prises à des heures régulières, mais dont on ne peut pas facilement prédire le nom de fichier. 

On va donc procéder différemment : on va lister l'ensemble des images disponibles dans le répertoire du 31 août 2012 à $211$Å. Pour cela, on va utiliser l'explorateur `lynx` (n'hésitez pas à appeler man lynx pour en savoir plus). `lynx` est un explorateur internet textuel, sans fenêtre graphique, qui s'affiche dans la console 😱.

!!! question

	Lancez lynx, décortiquez l'interface pour effectuer une recherche sur un
	moteur de recherche 

Je suis d’accord avec vous, cette manière d’explorer internet n’est pas très confortable. Mais, on peut utiliser lynx pour récupérer le contenu d’une page grâce à l’option dump `lynx -dump URL`. En ajoutant l’option `-listonly`, on ne récupère que la liste des références (les liens vers les images dans notre cas). Essayez la commande ci-dessous :

```bash
lynx -dump -listonly http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/ | less
```

Il apparaît le contenu de la page, converti en texte, dans lequel vous pouvez naviguer avec les flèches directionnelles. Le contenu affiché devrait ressembler à ça :

```
References

   1. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/
   2. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_00_11_63__SDO_AIA_AIA_211.jp2
   3. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_00_47_62__SDO_AIA_AIA_211.jp2
   4. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_01_23_62__SDO_AIA_AIA_211.jp2
   5. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_01_59_62__SDO_AIA_AIA_211.jp2
   6. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_02_35_62__SDO_AIA_AIA_211.jp2
   7. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_03_11_62__SDO_AIA_AIA_211.jp2
   8. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_03_47_62__SDO_AIA_AIA_211.jp2
   9. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_04_23_63__SDO_AIA_AIA_211.jp2
  10. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_04_59_62__SDO_AIA_AIA_211.jp2
  11. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_05_35_62__SDO_AIA_AIA_211.jp2
  12. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_06_11_63__SDO_AIA_AIA_211.jp2
  13. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_06_47_62__SDO_AIA_AIA_211.jp2
  14. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_07_23_62__SDO_AIA_AIA_211.jp2
  15. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_07_59_62__SDO_AIA_AIA_211.jp2
  16. https://jsoc1.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_08_35_62__SDO_AIA_AIA_211.jp2
```

Notez qu'on a redirigé la sortie standard de lynx dans l'entrée standard de `less`. `less` est un programme qui permet de parcourir du contenu texte (e.g. un fichier, mais il peut également lire depuis l'entrée standard).

!!! question

	**Écrivez** un script bash `scripts/get_index.sh` qui :

	- prenne le jour, le mois, l'année et la longueur d'onde des mesures à récupérer
	- récupère le contenu de la page grâce à `lynx -dump -listonly`
	- redirige dans la sortie standard le contenu téléchargé (on pourra utiliser le programme `cat` pour afficher dans la sortie standard le contenu d'un fichier)

## Extraire les URLs des images

Le contenu affiché par le script précédent contient beaucoup d'informations. On souhaite en extraire les URLs vers les images listées sur la page. Les URLs que nous cherchons à extraire ont un format très particulier ; elles commencent par "http://"  et finissent par ".jp2". Pour filtrer les lignes qui ne contiennent que ce motif, on va utiliser `gawk` et ce qu'on appelle des expressions régulières.


`awk` est un programme qui applique un programme sur un fichier (ou l'entrée standard) ligne par ligne. Un programme awk est de la forme 

> awk 'pattern { action }'

`awk` comprends ce mini-programme comme :

> si la ligne est filtrée par le patron *pattern* alors, on réalise l'action *action*"

Par ailleurs, `awk` divise la ligne selon un séparateur (modifiable par l'option `-FS sep`), qui est l'espace par défaut.

Prenons un exemple concret. Exécutez votre script `get_index.sh` et redirigez la sortie standard dans un fichier :


```.bash
bash:$ ./scripts/get_index.sh 31 08 2012 211 > 31_08_2012_211
bash:$ less 31_08_2012_211
```
 
On y retrouve bien la liste des liens vers les images. On va maintenant lire le fichier avec `cat` et le faire passer par `awk`.

```bash
bash:$ cat 31_08_2012_211 | awk '{ print $0 }'
bash:$ cat 31_08_2012_211 | awk '{ print $1 }'
bash:$ cat 31_08_2012_211 | awk '{ print $2 }'
```

Si vous voulez voir plus en détails la sortie de awk, n'hésitez pas à rediriger sa sortie dans less en ajoutant `| less`. 

Les *pattern* et *action* du programme `awk` peuvent prendre plusieurs formes (voir [http://www.gnu.org/software/gawk/manual/gawk.html#Patterns-and-Actions](http://www.gnu.org/software/gawk/manual/gawk.html#Patterns-and-Actions)), on ne va en voir ici que certaines d'entre elles. Dans l'exemple ci-dessus, nous n'avons pas précisé de *pattern*, toutes les lignes sont ainsi retenues et vous avez dû constater que la première commande affiche toute la ligne, la deuxième seulement le numéro du lien et la dernière l'adresse. Quand `awk` parcours une ligne, il crée plusieurs variables utilisables dans les *pattern* et *action*, en particulier les variables $0, $1, ... $NF qui permettent d'accéder aux champs extraits par `awk` ([http://www.gnu.org/software/gawk/manual/gawk.html#Fields](http://www.gnu.org/software/gawk/manual/gawk.html#Fields}). $0 est une variable particulière qui contient toute la ligne lue par `awk`. Les champs sont accessibles par les variables $1, $2, ... ; Il y a également d'autres variables, comme NF égal au nombre de champs dans la ligne, de telle sorte que $NF sera toujours le dernier champ extrait. La variable NR contient le numéro de ligne lu, etc.

À titre d'exemple, on peut facilement décoder la lettre envoyée par George Sand à Alfred de Musset ci-dessous :

```
Cher ami,
Je suis toute émue de vous dire que j'ai
bien compris l'autre jour que vous aviez
toujours une envie folle de me faire
danser. Je garde le souvenir de votre
baiser et je voudrais bien que ce soit
une preuve que je puisse être aimée
par vous. Je suis prête à montrer mon
affection toute désintéressée et sans cal-
cul, et si vous voulez me voir ainsi
vous dévoiler, sans artifice, mon âme
toute nue, daignez me faire visite,
nous causerons et en amis franchement
je vous prouverai que je suis la femme
sincère, capable de vous offrir l'affection
la plus profonde, comme la plus étroite
amitié, en un mot : la meilleure épouse
dont vous puissiez rêver. Puisque votre>
âme est libre, pensez que l'abandon ou je
vis est bien long, bien dur et souvent bien>
insupportable. Mon chagrin est trop
gros. Accourrez bien vite et venez me le
faire oublier. À vous je veux me sou-
mettre entièrement.
Votre poupée 
\end{verbatim}
\end{center}
```

en utilisant la commande awk : 


```bash
awk 'NR % 2 == 1 { print $0 }'
```

qui permet d'afficher toutes les lignes d'indice impair. La réponse de Musset ci-dessous :

```
Quand je mets à vos pieds un éternel hommage,
Voulez-vous qu'un instant je change de visage ?
Vous avez capturé les sentiments d'un coeur
Que pour vous adorer forma le créateur.
Je vous chéris, amour, et ma plume en délire
Couche sur le papier ce que je n'ose dire.
Avec soin de mes vers lisez les premiers mots,
Vous saurez quel remède apporter à mes maux. 
```

se décrypte facilement en utilisant awk. Le programme `decode_musset.awk` ci-dessous permet en effet de le décrypter :

```bash
awk -f decode_musset.awk musset_sand.txt
```

Dans le programme AWK, ORS signifie **Output Record Separator** c'est-à-dire le caractère utilisé entre chaque résultat filtré.

**decode_musset.awk**
```bash
BEGIN { ORS = " " } 
{ print $1 }
END { print "? \n" }

```

Le premier exemple utilise une expression arithmétique `NR % 2 == 1` comme *pattern*. On peut aussi utiliser des expressions régulières. Par exemple, pour vérifier si une ligne contient une URL vers une image au format jp2, on peut utiliser la commande awk : 

```bash
awk '/http:\/\\/.*\.jp2/ { print $2 }
```


Cette commande un peu étrange recherche, dans la ligne courante, une chaîne de caractère de la forme http:// (`http:\/\/`), suivi d'un nombre arbitraire de caractères (`.*`), suivi de .jp2 (`\.jp2`). Si cette expression régulière est vérifiée, alors le deuxième champ $2 est affiché. 

!!! question

	Ecrivez un script bash `scripts/extract_url.sh` qui, étant donné la liste des références obtenues avec Lynx, produise un flux dans la sortie standard des URL des images.

!!! question
	
	Testez le script que vous venez d'écrire en lui donnant en entrée un contenu récupéré par Lynx. Je vous propose d'utiliser le fichier 2012_08_31_211 que avez créé précédemment. Pour lire ce fichier et le rediriger vers l'entrée standard, nous utilisons la commande `cat`. Vous pouvez donc vérifier le fonctionnement de votre script par la commande ci-dessous~:
	
	```bash
	cat 31_08_2012_211 | ./scripts/extract_url.sh
	```


Cela devrait vous afficher les URLs de toutes les images. 

!!! note

	Pour n'en afficher qu'une partie, par exemple les 10 premières ou 10 dernières, vous pouvez utiliser les commandes `head` et `tail`:
	```bash
	cat 31_08_2012_211 | ./scripts/extract_url.sh | head -10
	```

	Ce qui devrait produire:
	```
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_00_11_63__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_00_47_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_01_23_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_01_59_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_02_35_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_03_11_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_03_47_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_04_23_63__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_04_59_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__00_05_35_62__SDO_AIA_AIA_211.jp2
	```

	```bash
	cat 31_08_2012_211 | ./scripts/extract_url.sh | tail -10
	```

	ce qui devrait produire:

	```
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_54_11_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_54_47_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_55_23_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_55_59_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_56_35_63__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_57_11_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_57_47_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_58_23_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_58_59_62__SDO_AIA_AIA_211.jp2
	http://jsoc.stanford.edu/data/aia/images/2012/08/31/211/2012_08_31__23_59_35_62__SDO_AIA_AIA_211.jp2
	```

Si vous voulez savoir combien d'images sont ainsi disponibles, on peut utiliser un compteur, incrémenté chaque fois que l'expression régulière est vérifiée :

```bash
awk 'BEGIN { sum = 0 } /http:\/\/.*\.jp2/ { sum = sum + 1 } END { print sum }'
```

Sur le fichier de dump utilisé précédemment, cela nous donne $2426$ images.

