# Recherche de fichier ou de contenu (grep, rg, find, locate)

Nous allons voir plusieurs outils pour rechercher des fichiers ou du contenu
dans des fichiers :

- `grep` : recherche de texte dans les fichiers,
- `rg` ([ripgrep](https://github.com/BurntSushi/ripgrep)) : une version très
  rapide de grep,
- `find` : recherche de fichiers selon des critères variés avec possibilité
  d'exécuter des commandes sur ces fichiers,
- `locate` : recherche rapide de fichiers grâce à une base de données.


## `grep`, `rg` : Rechercher du texte dans les fichiers

La commande GNU `grep` est installé par défaut sur votre système. Elle permet de
recherche du texte dans des fichiers.

Par exemple, la commande ci-dessous va rechercher "Error" dans le fichier
`/var/log/syslog`.

```bash
$ grep "Error" /var/log/syslog
```

Il est également possible d'effectuer une rechercher récursive. La commande
ci-dessous recherche récursivement le mot "Error" dans tout les fichiers de tout
les sous-répertoires de `/var/log`.

```bash
$ grep -r "Error" /var/log
```

Une commande très pratique pour rechercher un motif est la commande `grep -nri`
avec les options:

- `-n` : préfixe le mot trouvé du numéro de ligne dans le fichier dans lequel le
  mot est trouvé
- `-r` : recherche récursive
- `-i` : recherche insensible à la casse (indépendemment des
  minuscules/majuscules)

La commande `rg` (ripgrep) est un `grep` plus rapide mais qui n'est pas installé par défaut.


## `find` et `locate` : Rechercher un fichier

`find` et `locate` sont deux utilitaires en ligne de commande qui vous permettent de rechercher des fichiers sur votre disque dur. `locate` utilise une base de données (sous Fedora, cette base de données est
stockée dans le fichier `/var/lib/mlocate/mlocate.db`) des fichiers stockés sur le disque, qu'il va consulter lorsque vous faites une requête locate. Cette base de données n'est pas forcément mise à jour automatiquement et il peut être nécessaire de lancer la commande `updatedb`, en root, pour effectuer cette mise à jour. `find` quand à elle, parcours un répertoire cible que vous lui précisez à la recherche de votre fichier. Utiliser `locate` est plus rapide que `find` mais il faut bien s'assurer que la base est à jour pour que `locate` vous retourne vos résultats. Ces programmes vous permettent de rechercher des fichiers dans un ou plusieurs répertoires qui :

- ont des noms contenant un certain texte ou vérifiant une expression régulière
- contiennent du texte vérifiant une certaine expression régulière
- sont des liens vers d'autres fichiers
- ont été utilisé pendant une certaine période, font une certaine taille
- sont d'un certain type, appartiennent à un utilisateur ou groupe, ont des droits d'accès particuliers, 
- se trouvent à une certaine distance du répertoire d'o{\` u} la recherche est initiée

Vous pouvez rechercher des fichiers selon les critères ci-dessus mais également les voir, éditer, ajouter à une archive, renommer, changer les permissions, utilisateur, etc.. On trouvera beaucoup de détails
sur l'utilisation des outils `find` et `locate` sur la page findutils du projet GNU [http://www.gnu.org/software/findutils/manual/html_mono/find.html](http://www.gnu.org/software/findutils/manual/html_mono/find.html).

On donne ci-dessous quelques exemples typiques d'utilisation.


**Utilisation de locate**

Si la base de données de locate n'est pas à jour, il faut lancer
```bash
$ sudo updatedb
```

Pour faire une requête simple sur un nom de fichier, on utilise alors locate:
```bash
$ locate toto.titi
```

On peut aussi demander à updatedb d'indexer un répertoire et spécifier le fichier de base de données de sortie:

```bash
$ updatedb -U /chemin/a/indexer -o /chemin/vers/mabase.db -l 0
```

On utilisera alors locate en lui précisant la base de données à
utiliser

```bash
$ locate -d /chemin/vers/mabase.db toto.titi

```

Si vous avez besoin de rechercher un document dans un répertoire, il est plus facile d'utiliser la commande `find`.

**Utilisation de find**


Pour rechercher un fichier dont vous connaissez le nom dans un répertoire donné (e.g. votre home):

```bash
$ find ~ -iname monfichier.txt
```

Pour rechercher tous les fichiers PDF d'au moins 4 Mo: 

```bash
$  find ~ -name '*.pdf' -size +4M
```



La requête peut également être construite à l'aide d'une expression régulière. Par exemple, pour chercher tous les fichiers Makefile ou makefile sur son home, on utilisera (on trouvera plus de
  détails sur les expressions régulières à l'adresse [http://www.gnu.org/software/findutils/manual/html_mono/find.html\#Regular-Expressions](http://www.gnu.org/software/findutils/manual/html_mono/find.html\#Regular-Expressions)) :

```bash
$ find ~ -regex '.*/[Mm]akefile'
```

On a montré ici uniquement la façon d'appeler find pour rechercher des fichiers mais on peut également exécuter des commandes sur les
fichiers listés, avec l'option `-exec`. Par exemple : 

**Trouver tout les PDFs d'au moins 4M dans son home et obtenir leur taille**:

```bash
$  find ~ -name '*.pdf' -size +4M -exec du -sh \{} \;
```

Une autre manière de procéder pour appliquer une commande sur tous les fichiers trouvés par `find` est d'envoyer la sortie de standard `find` dans l'entrée
standard de `xargs`. Par exemple, pour copier tout les fichiers avec l'extension `.tex` d'une arborescence vers une autre :

**Trouver et copier des fichiers**

```bash
$  find /path/to/A -name '*.tex' | xargs -I{} cp {} /path/to/B 
```

On utilise ici `-I{}` pour capturer ce que reçoit en entrée la commande `xargs`
et le placer dans la chaîne de caractère `{}`. On peut alors utiliser dans la suite de la commande le symbole de
capture `{}`, très pratique quand il faut réorganiser les arguments de la
commande à exécuter. Par défaut, `xargs` va placer ce qu'il reçoit en entrée à
la fin de la commande que vous lui donnez.
