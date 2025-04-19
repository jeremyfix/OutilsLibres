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

<div class="player" id="demo"></div>
<script>
AsciinemaPlayer.create('../assets/count_files.cast', document.getElementById("demo"));
</script>


## Streaming (OpenBroadcast Studio OBS)

[OBS Studio](https://github.com/obsproject/obs-studio) est un outil qui va vous
permettre d'aller bien au delà de simplement enregistrer ce qui se passe sur votre écran puisque on a ici carrément affaire à un studio d'enregistrement. Vous allez pouvoir utiliser plusieurs sources vidéos et audio, les combiner et produire une vidéo ou streamer le résultat.

Pour en savoir plus, allez voir la documentation [https://obsproject.com/help](https://obsproject.com/help).
