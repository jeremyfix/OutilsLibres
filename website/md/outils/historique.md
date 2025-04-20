# Utiliser l'historique des commandes dans le shell (history, Ctrl+r)

Le programme [GNU history](https://tiswww.cwru.edu/php/chet/readline/history.html) se souvient de toutes les commandes que vous avez tapées dans le terminal. Pour voir le contenu de l'historique, 

```bash
$ history
```

que vous pouvez bien sûr combiner avec d'autres commandes. Par exemple, pour
rechercher dans l'historique les commandes utilisant `git`

```bash
$ history | grep git
```

Si vous voulez ré-exécuter une commande, rien de plus simple. Chaque ligne
listée par `history` a un index. Il vous suffit alors de taper `!` suivi du
numéro de ligne et votre shell va remplacer cette commande par la ligne
correspondante.

Pour recherche une commande dans l'historique, vous pouvez également faire un
"reverse search" en tapant les touches `Ctrl + r`. Votre shell vous propose
alors de taper un début de commande et il va compléter avec la commande qui
correspond le mieux. Vous pouvez cycler à travers les commandes qui
correspondent en ré-appuyant sur `Ctrl + r`.


