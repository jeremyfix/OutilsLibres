CIBLE=video.mp4
IMAGES_BRUTES=$(sort $(wildcard controller_*.png))
IMAGES_FFMPEG=$(patsubst controller_%, ffmpeg_controller_%, $(IMAGES_BRUTES))

all:$(CIBLE)
	@echo $(IMAGES_FFMPEG) >  list_ffmpeg_images.txt


$(CIBLE): $(IMAGES_FFMPEG)
	ffmpeg -i ffmpeg_controller_%04d.png -b 1M -r 1 $@


ffmpeg_controller_%.png: controller_%.png
	convert $< -background Khaki  label:'Epoch $*' -gravity Center -append  $@


clean:
	rm -f $(IMAGES_FFMPEG) $(CIBLE)

#convert test.png -colorspace Gray
#gray_colorspace.png
