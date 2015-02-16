

SUPPORT=support

tex_depends=$(wildcard *.tex)

all: 
	make tex

$(SUPPORT).pdf: $(tex_depends)
	pdflatex $(SUPPORT).tex
	pdflatex $(SUPPORT).tex
	pdflatex $(SUPPORT).tex

tex: $(SUPPORT).pdf

grab:
	shutter -w -e

grab-video:
	vlc screen:// :screen-fps=24 :screen-follow-mouse :screen-mouse-image="# # Mouse_pointer_small.png" ":sout=#transcode{vcodec=h264,venc=x264{scenecut=100,bframes=0,keyint=10}, vb=1024,acodec=none,scale=1.0, vfilter=croppadd{cropleft=0,croptop=0,cropright=0,cropbottom=0}} :duplicate{dst=std{mux=mp4,access=file,dst=screencast.mp4"}


clean:
	rm *.aux *.log *.toc *~ -f $(SUPPORT).pdf *.out *.cpt
