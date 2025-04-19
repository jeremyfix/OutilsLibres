# Capture d'écran photo et vidéo (OpenBroadcast Studio, gnome-screenshot)

## Capture photo/vidéo sous gnome

Si vous utilisez Ubuntu, il embarque l'outil [gnome-screenshot](https://gitlab.gnome.org/GNOME/gnome-screenshot) derrière la
commande "Take a screenshot". Cet outil vous permet d'enregistrer une photo et
une vidéo. 

Si vous voulez l'invoquer depuis la ligne de commande, il faudra l'installer :

```bash
$ sudo apt install gnome-screenshot
```

## Capture d'une session de terminal (asciinema)

Pour le cas d'usage très particulier d'enregistrer une session de terminal, vous
pouvez utiliser [asciinema](https://github.com/asciinema/asciinema). Il est très
simple d'utilisation, allez voir la documentation.

Par exemple, l'illustration ci-dessous de quelques commandes cascadées pour
compter le nombre de fichier dans un répertoire.


<div class="player" id="commande-0"></div>
<script>
    window.addEventListener("load", function(event) {
        AsciinemaPlayer.create("/OutilsLibres/assets/count_files.cast", document.getElementById("commande-0"), {
            cols: 80,
            rows: 24,
            autoPlay: false,
            preload: false,
            loop: false,
            startAt: "0:00",
            speed: 1.0,
            theme: "asciinema",
            fit: "width",
            controls: "auto",
            pauseOnMarkers: false,
            terminalFontSize: "small",
            terminalFontFamily: "",
            terminalLineHeight: 1.33333333,
        });
    });
</script>

## Streaming (OpenBroadcast Studio OBS)

[OBS Studio](https://github.com/obsproject/obs-studio) est un outil qui va vous
permettre d'aller bien au delà de simplement enregistrer ce qui se passe sur votre écran puisque on a ici carrément affaire à un studio d'enregistrement. Vous allez pouvoir utiliser plusieurs sources vidéos et audio, les combiner et produire une vidéo ou streamer le résultat.

Pour en savoir plus, allez voir la documentation [https://obsproject.com/help](https://obsproject.com/help).
