# Automatisation de tâches avec Makefile (make)

L'utilitaire GNU Make permet de construire des cibles en utilisant des règles à
partir de dépendances elles-mêmes construites à partir de règles dépendantes
d'autres dépendances, etc... et tout ceci en s'assuranr de n'appeler que les
règles strictement nécessaires pour finalement produire la cible qui vous
intéresse. De manière générale[^1], GNU make appelle une recette si jamais la cible
a une date de modification plus ancienne que ses dépendances.

Voir aussi :

- [Programmation/Make sur Wikibooks](https://fr.wikibooks.org/wiki/Programmation/Make)
- [Documentation de GNU make](https://www.gnu.org/software/make/manual/make.html)

[^1]:
	Certaines règles peuvent appliquer de manière inconditionnée, sans prendre
	en compte les dates de modification.
