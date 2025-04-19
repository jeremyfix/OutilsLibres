# Filtrage et manipulation de documents (awk, sed)


Les utilitaires `awk` et `sed` vous permettent de filtrer des documents selon leur contenu, voir d'effectuer des opérations sur ce contenu :

- `awk` traite un document organisé par colonnes, avec un séparateur
  paramétrable
- `sed` : permet de réaliser des remplaçements, suppressions, insertions, ...

Je ne vous cacherai pas que l'utilisation des outils `awk` et `sed` n'est pas immédiate notamment parce que ces outils reposent sur l'utilisation d'expressions régulières. Vous trouverez plusieurs exemples d'utlisation de ces commandes dans les TPs.

## awk

**Afficher la première colonne**

```bash
$ awk "{print $1}" document.txt
```

**Afficher la troisième colonne en précisant le séparateur ;**
```bash
$ awk -F';' '{print $3}' fichier.csv
```

**Afficher la troisième colonne si la deuxième colonne a une valeur plus petite
que 10**

```bash
$ awk -F';' '$2 < 10 {print $3}' fichier.csv
```

## sed

**Remplacer une chaîne par une autre**

La commande ci-dessous remplace (`s`) toutes les occurences (`g`) chaîne de caractères "avant" par "après" et retourne le résultat dans la sortie standard

```bash
$ sed 's/avant/après/g' fichier.txt
```

Pour réaliser le changement "en place" (*inplace*), il faudra ajouter l'option `-i`

**Expressions régulières**

On peut utiliser des expressions régulières. Par exemple, pour supprimer tous
les commentaires d'un fichier python :

```bash
$ cat monfichier.py | sed '/^[[:space:]]*#/d'
```

La commande précédente cherche toutes les lignes qui commence `^` ou non par des
espaces `[[:space:]]*`, suivi d'un '#' et supprime `d` cette ligne. On a utilisé
des classes de caractères, décrites dans [la documention de sed](https://www.gnu.org/software/sed/manual/html_node/Character-Classes-and-Bracket-Expressions.html).
