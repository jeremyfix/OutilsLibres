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
- etc...

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
- $755$ quand on veut $rwx$ pour le propriétaire mais supprimer $x$ pour tout
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
rendre un fichier (non-)modifiable, ou exécutable, vous utiliserez la commande
`chmod`. Cette commande prends en entrée les nouvelles permissions en octal.

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

Vous avez en général toute les permissions pour faire ce que vous voulez dans
cet espace. On trouvera ensuite des ré

!!! danger

	ici

## Installations logicielles

Pour installer des logiciels, il existe plein de façon mais disons que la
première à privilégier est de passer par le **gestionnaire de paquets** de votre
distribution. En fonction des familles de distribution, ce ne sera pas le même
gestionnaire :

- fedora/redhat : yum
- debian/ubuntu : apt
- arch : pacman
- MacOS : brew

Il existe des serveurs officiels, centralisés, sécurisés, qui hébergent les
logiciels. Bien sûr, tout un chacun peut également offrir un serveur de logiciel
et à ce moment là, à vous de choisir de prendre ou non le risque d'ajouter ce
dépôt logiciel. 



