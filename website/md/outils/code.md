# Editeur de texte, IDE (vim, emacs, code)

Pour coder sous Linux, vous avez plusieurs options. Parmi les IDE[^1] (*Integrated
Development Environments*) les plus populaires :

- [vim](https://www.vim.org/): éditeur en "ligne de commande", plutôt difficile à prendre en main, mais très agréable une fois cette courbe d'apprentissage passée. Vous pourrez
  éditer du code à distance (par exemple en étant connecté via ssh) comme quand vous éditez du code en local.
- [emacs](https://www.gnu.org/software/emacs/): IDE du projet GNU. Il est
  disponible en version "graphique" ou "ligne de commande". 
- [vs code](https://github.com/microsoft/vscode) : un IDE graphique
  all-inclusive avec énormément d'extensions 

VIM et Emacs sont des éditeurs complètement mutables. Par exemple, vous pouvez
définir comment votre éditeur se comportent quand il ouvre un certain type de
fichiers. Un éditeur comme VS code est certes plus abordable, mais plus
difficilement paramétrable. Dans tous les cas, choisissez l'éditeur qui vous
convient et paramétrez-le pour pouvoir programmer efficacement.

## VIM

Pour utiliser **vim**, vous devez apprendre vim et vous pouvez regarder la commande
`vimtutor`. Vous aurez une bien meilleure expérience avec VIM en lui ajoutant
quelques plugins. Plusieurs développeurs partagent leur "vimrc" sur github par
exemple, peut-être pourriez vous essayer [celui-la](https://github.com/amix/vimrc). Au minimum, voici quelques raccourcis bien utiles :

- vous naviguez dans la fenêtre avec les touches h, j, k ,l
- par défaut vous êtes en mode "normal". Pour éditer le contenu, vous devez
  passer en mode "insertion" en pressant `i`. Vous quittez le mode insertion
  avec `Echap`,
- on sauvegarde, depuis le mode "normal" avec la combinaison de touches `:w`
  suivi de "Entrée"
- on quitte, depuis le mode "normal" avec la combinaison de touches `:q`, suivi
  de Entrée

ça, c'est le kit de survie. Après, il faut apprendre :)

![VIM](../assets/vim.png)

## Emacs

**Emacs** n'est pas juste un IDE étant donné qu'il dispose également de plugins pour
planifier des tâches, écrire des mails, naviguer le système de fichiers, etc.
Comme pour VIM, si vous l'utilisez nu, sans configuration, vous n'aurez pas la
meilleure des expériences. Par contre, vous trouverez une configuration initiale
très complète avec [doomemacs](https://github.com/doomemacs/doomemacs) par
exemple.

![Doomemacs](https://raw.githubusercontent.com/doomemacs/doomemacs/screenshots/main.png)

Emacs peut paraître un peu austère mais il s'avère extrêmement pratique à partir du moment ou on connaît un certain nombre de
raccourcis clavier. Utiliser ces raccourcis clavier est un peu fastidieux au début mais devient rapidement un automatisme très
confortable. **Attention**: on indiquera un raccourcis comme Ctrl-X-F pour indiquer qu'il faut presser sur la touche Ctrl du clavier, la \underline{maintenir} enfoncée puis presser successivement les touches X et F. Lorsqu'on lance un raccourci, des informations peuvent être affichées dans la zone de texte tout en bas de l'éditeur. Voici une liste de raccourcis utiles :


- Ctrl - G : Annuler la commande en cours
- Ctrl - X - F : Ouvrir un fichier existant ou le créer
- Ctrl - _ : Annuler la dernière commande
- Ctrl - X - S : Sauvegarder un fichier
- Ctrl - K : Supprimer la ligne courante à partir du curseur
- Ctrl - W : Supprimer la sélection
- Ctrl - X puis H : sélectionner tout le texte du buffer courant (pratique si on poursuit par Tab pour indenter tous le buffer d'un coup)
- Tab : Indente la sélection (en fonction du mode courant)
- Ctrl - S : Rechercher dans le fichier ouvert
- Shift - Alt - % : Rechercher/Remplacer
- Ctrl - X puis Shift - 1 : Définir la disposition des fenêtre pour n'éditer qu'un buffer à la foi (voir les deux prochains raccourcis pour mieux comprendre!)
-  Ctrl - X puis Shift - 2 : Diviser en deux la fenêtre d'édition verticalement
-  Ctrl - X puis Shift - 3 : Diviser en deux la fenêtre d'édition horizontalement
-  Alt - X : Saisir directement une commande dans la zone de texte en bas de l'éditeur


Cette dernière commande qui se lit "Meta-X" permet d'accéder à la zone de texte sous l'éditeur (mini-buffer) et dans laquelle on peut saisir des commandes comme :
- goto-line : suivie d'entrée, elle permet de saisir une ligne à laquelle se rendre (pratique si la compilation d'un fichier échoue et qu'un numéro de ligne ou se trouve l'erreur est mentionné
- comment-region : commente la sélection
- uncomment-region : décommente la sélection
- ispell-change-dictionnary : pour changer le dictionnaire utilisé pour la correction orthographique en ligne
- flyspell-buffer : pour lancer le correcteur orthographique sur tous le buffer courant
- flyspell-mode : pour activer/désactiver la correction orthographique à la volée
- c++-mode : basculer en mode C++ (pour la coloration syntaxique, l'indentation, etc...)
- python-mode : basculer en mode Python (pour la coloration syntaxique, l'indentation, etc...)
- tuareg-mode : basculer en mode CamL (pour la coloration syntaxique, l'indentation, etc...)
- octave-mode : basculer en mode Octave (pour la coloration syntaxique, l'indentation, etc...)

N'oubliez pas que dans le monde Unix, la tabulation permet d'auto-compléter une commande. Par exemple, pour la commande
*uncomment-region*, il suffira de saisir *unc* suivi de Tabulation pour que la commande soit complétée. Si plusieurs commandes
ont le même préfixe, une liste des choix s'affiche si on appuis deux fois sur tabulation.


Revenons quelques instants sur la notion de mode dans emacs. emacs est écrit pour être modulable et adaptable à ses besoins (plus besoin d'un éditeur spécifique pour éditer du texte, du latex, du C++, etc. emacs se spécialise en fonction de l'extension du fichier édité). Les modes pour emacs introduisent justement cette flexibilité. On parlait plus haut des modes c++, python, tuareg qui modifient les menus de l'éditeur, les raccourcis claviers, l'indentation, la coloration syntaxique. Ces modes sont appelés **modes majeurs**. Il en existe plusieurs pour les langages de programmation les plus répandus ([http://fr.wikipedia.org/wiki/Emacs](http://fr.wikipedia.org/wiki/Emacs)). En pratique, ces modes sont écrits comme des scripts Lisp. Il est également possible de personnaliser l'interface à l'aide de scripts Lisp.

## VS Code

VS Code est un très bon outil. Il vient tout équipé, avec une très grande
collection d'extensions. Vous pourrez coder dans plein de langage, avec
débugueur intégré, modèles de langue (e.g. copilot), plugin GIT, terminal, etc. 

![VS Code](../assets/vscode.png)


[^1]: 
	Coder se fait avec un IDE. Les outils tels que gedit, nano ne sont pas des
	IDE, ce sont des éditeurs de texte. Un IDE vous offre la coloration
	syntaxique, l'indentation, un débugueur, etc.
