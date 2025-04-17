# Assembler des images en vidéo (ffmpeg, avconv)

Si vous disposez d'un ensemble d'images que vous souhaitez assembler en une vidéo `ffmpeg` et `avconv` vous le permettent. Par exemple, vous lancez une simulation depuis laquelle vous sauvegardez des images et vous souhaitez les animer. 

En imaginant que vous disposez d'une collection d'image dont le nom
est de la forme Image-xxxx.ppm, vous pouvez les regrouper en une vidéo
avec une commande du type:

```bash
$ ffmpeg -i Image-%05d.ppm -b 1M movie.avi
```

Sachez que ffmpeg gère plusieurs formats d'images (voir [http://ffmpeg.org/general.html#Image-Formats](http://ffmpeg.org/general.html#Image-Formats)). L'option `-b 1M` contrôle la qualité (et la taille) de la vidéo générée.

J'en profite pour ajouter une petite note et reboucler avec la partie sur les [Makefile](autotask.md). Si vous souhaitez créer une vidéo à partir d'une collection d'images mais que vous avez envie de travailler les images pour y incruster des éléments, pas de soucis, on peut combiner ImageMagick, Makefile et ffmpeg pour nous aider. 

On partira du principe que ce sont les mêmes traitements à appliquer à toutes les
images. Makefile est capable de lister l'ensemble des images d'un répertoire (`wildcard`), de les ordonner (c'est plus facile de suivre o{\`u} en est le traitement, parce que sinon Makefile traitera les images dans un ordre aléatoire). ImageMagick peut ensuite appliquer un traitement à toutes ces images et enfin ffmpeg les assemble pour créer une vidéo. L'encadré ci-dessous donne un exemple de Makefile pour ce
scénario, avec une simple conversion de l'image en niveau de gris avant un
assemblage en une vidéo.

```makefile
CIBLE=video.avi
IMAGES_BRUTES=$(sort $(wildcard Image-*.png))
IMAGES_FFMPEG=$(subst Image, image-ffmpeg, $(IMAGES_BRUTES))

image-ffmpeg-%.png: Image-%.png
	convert $< -colorspace Gray $@

$(CIBLE): $(IMAGES_FFMPEG)
	ffmpeg -i $< -b 1M $@
```
