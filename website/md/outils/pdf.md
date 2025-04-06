# Manipulation de documents PDF (pdftk)

Si vous devez fusionner ou séparer des PDFs, tourner des pages, etc.. 
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
