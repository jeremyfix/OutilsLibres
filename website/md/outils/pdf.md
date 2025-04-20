# Manipulation de documents PDF (pdftk, xournalpp)

## Extraction, insertion, concaténation, rotations des pages (pdftk)

Si vous devez fusionner ou séparer des PDFs, tourner des pages, etc. 
`pdftk` est l'outil qu'il vous faut :

**Extraire les $3$ premières pages d'un pdf**
```
$ pdftk fichier.pdf cat -3 output sortie.pdf
```

**Fusionner $2$ fichiers PDF**

```
$ pdftk A=fichier1.pdf B=fichier2.pdf cat A3-4 B5-6 output sortie.pdf
```

Pour plus d'exemples :

```
$ tldr pdftk
```

## Annotation d'un document PDF (xournal++)

Si vous avez d'annoter un document PDF (e.g. un rapport, un document à signer),
le programme [xournal++](https://xournalpp.github.io/) est idéal. 

Vous pouvez l'utiliser pour ajouter des annotations manuscrites, tapuscrites,
insérer des images, etc...

![Xournal++, image provenant du site du logiciel](https://xournalpp.github.io/img/Physics%20Problem.png)
