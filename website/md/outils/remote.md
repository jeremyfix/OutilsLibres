# Interaction avec une machine distante

Vous allez très certainement être confrontés à interagir avec des machines à
distance, parfois même des serveurs qui ne disposent pas de clavier/souris. Les
commandes présentées dans ce chapitre vous montrent comment :

- vous connecter à distance à une machine voir, exécuter des commandes à
  distance (`ssh`)
- transférer des fichiers vers ou depuis une machine distante (`scp`, `rsync`)
- "monter" un volume distant pour y accéder localement (`sshfs`)


## Se connecter à une machine distante

Quand on a besoin de se connecter à une machine distante, si celle-ci est
équipée d'un serveur ssh, on peut utiliser la commande `ssh` en ligne de
commande  :

```
$ ssh monlogin@ip_de_la_machine
```

et votre terminal se retrouve connecté au serveur dont l'adresse IP est
`ip_de_la_machine`. Si jamais le serveur ssh de la machine distante n'écoute pas
sur le port standard $22$, on peut l'indiquer par l'option `-p port`.

Il est plutôt confortable de se définir des alias ssh. Ils sont définis dans le
fichier `~/.ssh/config`.

Par exemple, si vous mettez le contenu ci-dessous :

```
Host raspi
	Hostname 82.99.234.239
	User monlogin
	Port 2222
```

Il vous permet de lancer la commande `ssh raspi` qui correspond à `ssh
monlogin@82.99.234.239 -p 2222`.

Parfois, on a besoin de passer par une machine rebond (e.g. firewall) avant
d'arriver sur la machine cible. On peut facilement le définir en ligne de
commande bien sûr mais c'est plus confortable de le définir dans son
`~/.ssh/config`. Par exemple si on veut atteindre `host1` en rebondissant sur la
machine `proxy1.domain.com`

```
Host host1
	Hostname host1
	User monlogin_sur_host1
	ProxyCommand ssh proxy1 -W %h:%p

Host proxy1
	Hostname proxy1.domain.com
	User monlogin_sur_proxy1
```

et vous pourrez alors simplement lancer la commande `ssh host1` depuis votre
machine locale ! 

## Exécuter des commandes à distance

Avec la commande `ssh` vous pouvez vous connecter sur un hôte distant, mais vous
pouvez aussi directement exécuter une commande sur cet hôte. Par exemple :

```
$ ssh host1 "df -h"
```

## Transférer des fichiers ou depuis une machine distante

## Monter un volume distant

## Authentification alternative au mot de passe, par clé ssh

## Multiplexeur de terminal 

Un multiplexeur de terminal vous permet de :

- virtuellement disposer de plusieurs fenêtres de terminal dans une même fenêtre. Cela s'avère extrêmement pratique en
particulier lorsque vous interragissez avec une machine à distance,
- laisser un processus vivant, même si on est déconnecté d'une machine distante
