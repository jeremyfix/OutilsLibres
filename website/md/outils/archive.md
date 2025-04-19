# Archiver/désarchiver (tar, gzip, zip)

Les outils GNU [tar](https://www.gnu.org/software/tar/manual/html_node/index.html) et [gzip](https://www.gnu.org/software/gzip/manual/html_node/index.html) permettent de compresser des fichiers/répertoires.

tar permet de créer et d'extraire des archives avec les extensions .tar ou .tar.gz. Pour compresser le répertoire `Toto` dans l'archive `toto.tar.gz`, on utilisera la commande:

```bash
$ tar -zcvf toto.tar.gz Toto
```

Pour extraire l'archive `toto.tar.gz` on utilisera la commande (notez que c'est juste le **c** changé en **x** pour **c**ompress vs e**x**tract.

```bash
$ tar -zxvf toto.tar.gz Toto
```

Il y a également l'outil [zip](https://infozip.sourceforge.net/Zip.html). Des
exemples d'utilisation sont disponibles en invoquant la commande `tldr zip`.

