# Automatisation de tâches avec Makefile (make)

L'utilitaire GNU Make permet de construire des cibles en utilisant des règles à
partir de dépendances elles-mêmes construites à partir de règles dépendantes
d'autres dépendances, etc. et tout ceci en s'assurant de n'appeler que les
règles strictement nécessaires pour finalement produire la cible qui vous
intéresse. De manière générale[^1], GNU make appelle une recette si jamais la cible
a une date de modification plus ancienne que ses dépendances.



On a vu et on verra des commandes à exécuter dans un terminal pour résoudre un certain nombre de problèmes (vérifier l'orthographe d'un texte, travailler des images, regrouper des images pour créer une vidéo, lister/modifier un ensemble de fichiers, compiler un document \LaTeX, compiler un programme, etc.). Il peut devenir difficile de se souvenir de la syntaxe
d'une commande et la syntaxe peut même devenir compliquée quand on
souhaite enchaîner des commandes. Imaginez alors devoir enchainer plusieurs de
ces commandes, un cauchemar. GNU Make est un des outils qui permet d'automatiser l'exécution de tâches. L'outil `make` est installé avec le paquet `make` et en général installé par défaut avec la distribution. 

## Makefile

L'utilisation de `make` passe par la définition de fichiers Makefile qui sont traités par la commande make. Ces fichiers peuvent s'appeler *GNUmakefile*, *makefile*, ou *Makefile*. Ils contiennent un ensemble de règles avec une forme canonique :

```
cible: dépendances
       commandes
```

Une règle doit être comprise comme définissant une recette de cuisine (les commandes) permettant de construire une cible si les dépendances ont changé. Les dépendances sont optionnelles, on en verra un exemple un peu plus loin. **Attention** chaque ligne de commande doit être précédée par une tabulation. 


## Example de compilation d'un document LaTeX

On considère un exemple assez standard pour illustrer quelques concepts de Make,
celui de compiler un document LaTeX. On verra plus tard que pour compiler le
document *document.tex*, on peut utiliser l'outil [latexmk](rapport.md). Si on devait l'écrire dans
le terminal on aurait alors :

```bash
$ latexmk -pdf document.tex
```

Avec make, on peut définir une cible *document.pdf* et un alias *tex* de la manière suivante :

**Fichier Makefile**
```
document.pdf: document.tex
	latexmk -pdf document.tex

tex: document.pdf
```

Maintenant, plus besoin de se souvenir de la commande, un simple appel à 

```bash
make tex
```

suffit à recompiler le document. D'autre part, le document ne sera recompilé que si document.tex change. La compilation
d'un document LaTeX produit plusieurs fichiers temporaires à supprimer pour faire le ménage. La cible *clean* ci-dessous
est un exemple de cible sans dépendance. On ajoute également la cible *all* qui est la cible appelée par défaut si on exécute `make` sans préciser de cible ainsi qu'une cible *help* pour afficher un message d'aide. **Attention**, je rappelle que chaque ligne de commande est précédée d'une tabulation !(et pas des espaces)}.\\

**Fichier Makefile**
```
document.pdf: document.tex
	latexmk -pdf document.tex

tex: document.pdf

clean:
	latexmk -C

all:
	make help

help:
	@echo "Cibles disponibles:"
	@echo "clean : nettoie le répertoire"
	@echo "tex  : compile le document"

```

## Variables et règles génériques

Avec `make`, il existe quelques variables et syntaxes particulières, du style %@, %<, %.o qui permettent d'écrire des règles
génériques. Ces variables ne sont qu'une partie des variables automatiques
introduites par `make` (voir [http://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables](http://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables)) pour une liste complète des variables automatiques}. Par exemple, si vous écrivez un Makefile pour compiler un projet C++, la règle de compilation est de la forme : 

```bash
$ gcc -c fichier.cc -o fichier.o  -O3 -Wall...
```

Si mon projet comprend 3 fichiers c++ à compiler et une phase d'édition de lien pour créer l'exécutable, on
pourrait l'écrire ainsi **mais c'est la mauvaise façon de procéder** :

**Première proposition, non satisfaisante, de Makefile**

```
fichier1.o : fichier1.cc
          gcc -c fichier1.cc -o fichier1.o -O3 -Wall
fichier2.o : fichier2.cc
          gcc -c fichier2.cc -o fichier2.o -O3 -Wall
fichier3.o : fichier3.cc
          gcc -c fichier3.cc -o fichier3.o -O3 -Wall
monbinaire: fichier1.o fichier2.o fichier3.o
          gcc -o monbinaire fichier1.o fichier2.o fichier3.o
```

Les commandes pour compiler fichier*.cc étant les mêmes, on peut les écrire de manière plus compacte :

**Fichier Makefile**

```
%.o : %.cc
     gcc -c $< -o $@ -O3 -Wall

monbinaire: fichier1.o fichier2.o fichier3.o
     gcc -o $^
```

En appelant 

```bash
$ make monbinaire
```

make s'occupe de recompiler les fichiers ainsi que le binaire si nécessaire. La variable $@ fait référence à la cible de la règle, $< fait référence à **la** dépendance et $^ à toutes les dépendances. On trouvera plus d'informations sur ces variables spéciales à l'adresse [http://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html](http://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html).

Enfin, on peut aussi générer la liste des fichiers à compiler automatiquement. Pour cela, on dispose des fonctions wildcard et patsubst. 

**Fichier Makefile**

```
OBJ := $(patsubst %.cc,%.o,$(wildcard *.cc))

%.o : %.cc
     gcc -c $< -o $@ -O3 -Wall

monbinaire: $(OBJ)
     gcc -o $^
```

On a ici construit une variable `OBJ` qui est une liste construite de la manière suivante : on cherche tous les fichiers avec
l'extension .cc (`wildcard *.cc`) et on remplace l'extension .cc par .o. Il suffit alors de changer la dépendance du binaire par le contenu de la variable `OBJ` et le tour est joué. Maintenant, chaque fois qu'on ajoutera un fichier .cc, il sera automatiquement ajouté à la liste des fichiers à compiler. 

On trouvera plus de détails sur les fonctions *wildcard* et *patsubst* ainsi que d'autres fonctions utilisables dans les makefiles aux adresses suivantes :

- [http://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html#Wildcard-Function](http://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html#Wildcard-Function)
- [http://www.gnu.org/software/make/manual/html_node/Functions.html#Functions](http://www.gnu.org/software/make/manual/html_node/Functions.html#Functions)

## Pour aller plus loin

Il y a plein d'autres aspects que nous n'avons pas abordés comme l'utilisation de makefile récursifs (un makefile à la racine
  d'un projet appelant des makefile des répertoires fils), la définition et manipulation de variables, et d'autres éléments
  expliqués dans la documentation.

On notera aussi qu'il existe une grande variété d'outils pour automatiser des tâches comme [cmake](https://cmake.org), [qmake](https://doc.qt.io/qt-6/qmake-manual.html) (surtout utilisé pour des projets reposant sur la librairie Qt), [scons](https://scons.org/) (surtout utilisé dans le monde Python), [ant](https://ant.apache.org/) ou [maven](https://maven.apache.org/) (surtout utilisé dans le monde Java), [gradle](https://gradle.org/), etc. 

Voir aussi :

- [Programmation/Make sur Wikibooks](https://fr.wikibooks.org/wiki/Programmation/Make)
- [Documentation de GNU make](https://www.gnu.org/software/make/manual/make.html)

[^1]:
	Certaines règles peuvent appliquer de manière inconditionnée, sans prendre
	en compte les dates de modification.
