# Familiarisation avec l'environnement Unix

!!! danger

	wip

## Permissions

Les permissions sont extrêmement importantes sous Linux. Chaque utilisateur
Linux a un nom d'utilisateur et appartient à un ou plusieurs groupes.

Les commandes ci-dessous vous indiquent ces éléments :

```
id
echo $USER
groups
```

En fonction des groupes auxquels un utilisateur appartient, il va disposer de
droits particuliers. Par exemple :

- un membre du groupe `sudo` va pouvoir passer **super utilisateur** et faire
  tout ce qu'il veut sur le système comme installer des logiciels, lire des
  fichiers de sécurité, supprimer n'importe quoi
- un membre du groupe `docker` va pouvoir lancer des images docker
- un membre du groupe `lpadmin` va pouvoir administrer le serveur d'impression
  CUPS, 
- …

Sur les machines de l'école, vous êtes en général membre d'un groupe regroupant
l'ensemble des collègues de votre promotion. 

Les permissions données à un groupe dépendent de *flags*. Ces permissions sont
de trois types :

- permission de lire un fichier ou lister le contenu d'un répertoire
- permission d'écrire (modifier) un fichier, ou de créer, supprimer, déplacer
  des éléments d'un répertoire
- permission d'exécuter un fichier et d'accéder au contenu d'un répertoire.

Ces permissions sont bien souvent notées "rwx" pour r-ead, w-rite, e-x-ecute,
donc 3 *flags*, chacun binaire, $8$ possibilités en tout de $0$ à $7$. Chaque
fichier/répertoire appartient toujours à un utilisateur et à un groupe, ce qui
conduit à $3$ groupes de permissions :

- le propriétaire du fichier/répertoire
- les membres du groupe propriétaire du fichier/répertoire
- le reste du monde

Comme on a $3$ paquets de $3$ permissions, on les représente habituellement en
octal avec $3$ chiffres entre $0$ et $7$ pour chaque groupe d'utilisateurs. On
parlera par exemple de permissions :

- $777$ pour rwx pour les $3$ groupes d'utilisateurs
- $755$ quand on veut $rwx$ pour le propriétaire, mais supprimer $x$ pour tous
  les autres
- $600$ pour `rw` pour l'utilisateur, mais sans droit de lecture/modification
  pour les autres, ce qui est requis pour une clé ssh privée
- $644$ pour `rw` pour l'utilisateur et les droits de lecture pour les autres,
  ce qui est requis pour une clé publique SSH.

Pour accéder aux propriétés d'un fichier/répertoire, un `ls -l` vous les
liste, et on trouvera par exemple :

```.bash
-rw-r--r--   1 fix_jer morbluc        5096 déc.  23 09:31  .zshrc
```

Les permissions sont indiquées tout à gauche : `rw-r--r--`. Le premier tiret `-`
est un flag particulier pour indiquer si on a affaire à un fichier `-`, un
répertoire `d` ou un lien symbolique `l`.

Pour les permissions sur ce fichier, si on les décortique :
- l'utilisateur `fix_jer` a le droit de lire et modifier le fichier (mais pas
  d'exécuter)
- les utilisateurs du groupe `morbluc` ont le droit de lire le fichier (mais pas
  d'écrire ni d'exécuter)
- les autres utilisateurs ont le droit de lire le fichier (mais pas d'écrire ni
  d'exécuter)

Prenons un autre exemple 

```bash
ls -l /proc/
dr-xr-xr-x   6 root root 0 avril  1 06:01 tty
-r--r--r--   1 root root 0 avril  1 06:00 uptime
-r--r--r--   1 root root 0 avril  1 06:01 version
-r--r--r--   1 root root 0 avril  1 06:01 version_signature
-r--------   1 root root 0 avril  1 06:01 vmallocinfo
-r--r--r--   1 root root 0 avril  1 06:01 vmstat
-r--r--r--   1 root root 0 avril  1 06:01 zoneinfo
```

On voit ici plusieurs permissions, chaque fois pour l'utilisateur `root` et le
groupe `root`. Si vous avez besoin de modifier les permissions, par exemple pour
rendre un fichier (non-)modifiable ou exécutable, vous utiliserez la commande
`chmod`. Cette commande prend en entrée les nouvelles permissions en octal.

```
info "File permissions"
```

## Système de fichiers

Les répertoires Linux respectent une certaine organisation. D'abord, ils ne sont
pas organisés comme sous Windows en "C:/xxxx/yyy/" mais sont explicitement une
structure arborescente commençant par un slash "/" qui est ce qu'on appelle "la
racine" du système de fichier. Et on trouve ensuite des sous-répertoires :

```
/
/home/fix_jer
/etc/
/var/log
/proc/
/opt/
/tmp/
/usr/
...
```

Et je vous invite à lire les pages de manuel à ce sujet :

```
info file-hierarchy
man file-hierarchy
```

Vos fichiers/répertoires sont dans votre espace utilisateur, qu'on appelle "le
home". On peut le localiser avec la variable d'environnement `$HOME` :

```
echo $HOME
```

Vous avez en général toutes les permissions pour faire ce que vous voulez dans
cet espace. On trouvera ensuite des répertoires qui hébergent des fichiers pour
une certaine fonction :

- `/etc` va contenir des fichiers de configuration. Par exemple un serveur nginx mettre ses fichiers de configuration dans `/etc/nginx`. Le gestionnaire de paquet sous Ubuntu met ses fichiers de configuration dans `/etc/apt/`, ...
- `/var/log` va contenir les logs de différents processus qui tournent sur votre
  système. Par exemple `/var/log/Xorg.0.log` contiendra les logs du serveur
  d'affichage Xorg, `/var/log/apacha`
- `/usr/bin` contient les exécutables
- `/usr/include` les fichiers d'entête des librairies C/C++ installées
- `/usr/lib` les librairies installées
- `/run/user/` des fichiers temporaires des processus en cours d'exécution pour un
  utilisateur
- `/tmp` un répertoire nettoyé au démarage qui n'a vocation qu'à héberger des
  fichiers temporaires
- `/dev/` un répertoire contenant des fichiers pour interagir avec des
  périphériques. Par exemple `/dev/js0` pour un joystick, `/dev/video0` pour une
  webcam, ...
- `/mnt` contient en général les points de montage par exemple de clés/disques
  USB branchés, de périphériques réseaux, etc..
- ...

## Installations logicielles

Pour installer des logiciels, il existe plein de façon, mais disons que la
première à privilégier est de passer par le **gestionnaire de paquets** de votre
distribution. En fonction des familles de distribution, ce ne sera pas le même
gestionnaire :

- fedora/redhat : yum
- debian/ubuntu : apt
- arch : pacman
- MacOS : brew

Le gestionnaire de paquet est construit pour gérer lui même les éventuelles
dépendances d'un logiciel. Pas besoin de le faire vous même. Il garde également
une trace des paquets installés par dépendance, de telle que si vous supprimez
un paquet, il peut vous suggérer de supprimer les paquets installés par
dépendance. Pratique pour faire le ménage !

Il existe des serveurs officiels, centralisés, sécurisés, qui hébergent les
logiciels. Bien sûr, tout un chacun peut également offrir un serveur de logiciel
et à ce moment-là, à vous de choisir de prendre ou non le risque d'ajouter ce
dépôt logiciel. 

Par exemple, pour installer VS Code sous Ubuntu 

```bash
$ sudo apt info code
Package: code
Version: 1.99.1-1743784529
Priority: optional
Section: devel
Maintainer: Microsoft Corporation <vscode-linux@microsoft.com>
Installed-Size: 423 MB
Provides: visual-studio-code
Depends: ca-certificates, libasound2 (>= 1.0.17), libatk-bridge2.0-0 (>= 2.5.3), libatk1.0-0 (>= 2.11.90), libatspi2.0-0 (>= 2.9.90), libc6 (>= 2.14), libc6 (>= 2.16), libc6 (>= 2.17), libc6 (>= 2.2.5), libc6 (>= 2.25), libc6 (>= 2.28), libcairo2 (>= 1.6.0), libcurl3-gnutls | libcurl3-nss | libcurl4 | libcurl3, libdbus-1-3 (>= 1.9.14), libexpat1 (>= 2.1~beta3), libgbm1 (>= 17.1.0~rc2), libglib2.0-0 (>= 2.37.3), libgtk-3-0 (>= 3.9.10), libgtk-3-0 (>= 3.9.10) | libgtk-4-1, libnspr4 (>= 2:4.9-2~), libnss3 (>= 2:3.30), libnss3 (>= 3.26), libpango-1.0-0 (>= 1.14.0), libudev1 (>= 183), libx11-6, libx11-6 (>= 2:1.4.99.1), libxcb1 (>= 1.9.2), libxcomposite1 (>= 1:0.4.4-1), libxdamage1 (>= 1:1.1), libxext6, libxfixes3, libxkbcommon0 (>= 0.5.0), libxkbfile1 (>= 1:1.1.0), libxrandr2, xdg-utils (>= 1.0.2)
Recommends: libvulkan1
Conflicts: visual-studio-code
Replaces: visual-studio-code
Homepage: https://code.visualstudio.com/
Download-Size: 104 MB
APT-Sources: https://packages.microsoft.com/repos/code stable/main amd64 Packages
Description: Code editing. Redefined.
 Visual Studio Code is a new choice of tool that combines the simplicity of
 a code editor with what developers need for the core edit-build-debug cycle.
 See https://code.visualstudio.com/docs/setup/linux for installation
 instructions and FAQ.

$ sudo apt install code
...
```

## Philosophie Unix : Do One Thing and Do It Well

Comme vous le verrez dans la suite du site et pendant les TPs, on va combiner
pleins de "petites" commandes. La philosophie Unix est d'écrire des "petits"
programmes qui s'attaquent à un problème en particulier avec l'idée de pouvoir
combiner tout ces programmes entre eux. 

La manière de combiner des programmes entre eux se fait grâce au "pipe", le
symbole `|`. Dans le TP [Bash à sable](../tps/bash.md), on discutera justement
de l'"entrée standard", la "sortie standard" et la "sortie d'erreur". Ce sont
des entrées/sorties qui sont connectées par des "pipe" (tuyaux).

Par exemple, pour **trouver les $10$ plus gros fichiers dans un répertoire**, on
peut combiner :

- `du` qui retourne la taille occupée par un fichier/répertoire
- `sort` qui trie ce qu'il reçoit en entrée avec la possibilité que les nombres
  à trier soient suffixés d'une unité **M**ega, **G**iga
- `tail` qui ne retient que les $x$ dernières lignes de ce qu'il reçoit en
  entrée

Combinez ensemble, on obtient la commande `du * -sh | sort -h | tail -10` qui va
vous retourner les $10$ plus gros fichiers/répertoires dans le répertoire
courant.

Autre exemple, pour calculer **combien de fichiers sont présents dans un
répertoire**, on peut combiner :

- `ls` qui liste tous les éléments présents dans un répertoire et, avec l'option
  `-p` lui demander de suffixer les répertoires du symbole `/`
- `grep` qui permet de rechercher un motif. On lui demande de recherche le motif
  `/` et de retourner ce qui ne contient pas ce motif `-v`
- `wc` qui permet de compter le nombre de lignes `-l` (mais peut aussi compter
  le nombre de mots `-w`, de caractères `-c`, ...)

Ce qui donne la commande `ls -p | grep -v / | wc -l`
