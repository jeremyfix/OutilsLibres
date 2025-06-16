# Correction orthographique/grammaticale (aspell, hunspell, LanguageTool)

Il existe un certain nombre de logiciels libres pour la correction orthographique et/ou grammaticale, notamment `ispell`, [aspell](https://github.com/GNUAspell/aspell), myspell, [hunspell](https://hunspell.github.io/), [LanguageTool](https://github.com/languagetool-org/languagetool), ... . 

L'historique des différentes versions xxxspell n'est pas très clair. ispell semble être le plus ancien, sur lequel est basé myspell; aspell semble avoir été développé pour prendre le relais d'ispell. hunspell quant à lui est le correcteur orthographique qui semble prendre la main[^1]; il est utilisé dans un grand nombre d'applications comme Firefox, Thunderbird, Chrome, Eclipse…, 

LanguageTool semble avoir été développé plus récemment et indépendamment. Contrairement
aux xxx-spell, LanguageTool corrige les formes de style évitant ainsi, par exemple, l'utilisation de pléonasmes (au jour d'aujourd'hui), l'utilisation de deux virgules consécutives, etc.

Pour installer ces logiciels (on préférera aspell, hunspell ou LanguageTool) sous Fedora :

```bash

# Aspell

## Sur Fedora/RedHat
# yum install aspell aspell-fr aspell-en
dnf install aspell aspell-fr aspell-en

## Sur Ubuntu/Debian
apt install aspell aspell-fr aspell-en


# Hunspell

## Sur Fedora/RedHat
# yum install hunspell hunspell-fr hunspell-en
dnf install hunspell hunspell-fr hunspell-en

## Sur Ubuntu/Debian
apt install hunspell hunspell-fr hunspell-en

# LanguageTool
# Aller voir sur la page du projet
```

Tous ces outils sont utilisables en ligne de commande (i.e. dans un terminal, depuis un Makefile, ...). Pour tester les possibilités des différents correcteurs, on partira du texte ci-dessous, les fautes étant indiquées en rouge :

Maître Corbeau, sur un arbre {==perchai==},<br/>
{==Tenais==} en son {==beck==} un fromage.<br/>
Maître Renard, par l'odeur alléché,<br/>
Lui tint à peu près ce langage :<br/>
"Hé ! bonjour, Monsieur du Corbeau.<br/>
Que vous êtes joli ! que vous me semblez beau !<br/>
Sans mentir, si votre ramage<br/>
Se rapporte à votre plumage,<br/>
Vous êtes le Phénix des hôtes de ces bois. "<br/>
A ces mots le Corbeau ne se sent pas de joie ;<br/>
Et pour montrer sa belle voix,<br/>
Il ouvre un large bec, laisse tomber sa proie.<br/>
Le Renard s'en {==saisie==}, et dis : "Mon bon Monsieur,<br/>
{==Apprené==} que tout flatteur<br/>
Vit aux dépens de celui qui l'écoute :<br/>
Cette leçon vaut bien un fromage, sans doute. "<br/>
Le Corbeau, honteux et confus,<br/>
Jura, mais un peu tard, qu'on ne l'y prendrait plus.

## Aspell

aspell s'appelle avec une commande de la forme :

```bash
$ aspell check [options] filename
```

Plusieurs options sont disponibles, on ne liste que les plus utiles, mais d'autres sont documentées sur la [documentation](http://aspell.net/man-html/Spellchecking-Individual-Files.html\#Spellchecking-Individual-Files)

- `--lang=name` avec name $\in$ (fr, en, ..) spécifie le langage,
- `--mode=mode` avec mode $\in$ (none, url, email, sgml, tex, texinfo, nroff,
  ...) permet de filtrer des mots spécifiques de langage (par exemple le mode
  tex permet de ne pas considérer les mots clefs LaTeX)

Pour plus d"informations sur les options :

```bash
$ aspell --help
```

Par exemple, pour corriger les fautes d'orthographes d'un fichier texte, on utilisera:
```bash
$ aspell check -lfr text.txt
```

Pur corriger les fautes d'orthographes d'un fichier LaTeX, on utilisera:

```bash
$ aspell check -lfr --mode=tex text.tex
```

Ces deux commandes lancent aspell en mode interactif, permettant de corriger les fautes à la volée (le fichier original est modifié). On peut aussi lister les fautes, sans les corriger. Sur le texte de Jean de la Fontaine, aspell retourne :

```bash
$ cat original.txt | aspell -lfr list
beck
Apprené
```

## Hunspell

hunspell fonctionne de manière similaire à aspell, les options étant spécifiées de manière un peu différente. Pour avoir plus d'informations sur les options à passer au programme, on utilisera
```bash
$ hunspell --help
```

Pour vérifier l'orthographe d'un texte en français, on utilisera la commande :

```bash
$ hunspell -d fr_FR text.txt
```

Pour vérifier un document \LaTeX, on précisera l'option `-t`:

```bash
hunspell -d fr_FR -t text.tex
```

On peut aussi lister les fautes, sans les corriger. Sur le texte de Jean de la Fontaine, hunspell retourne:

```bash
hunspell -d fr_FR -l original.txt
beck
Apprené
```

## LanguageTool

Il y a plusieurs façons d'utiliser language tool. Parfois, il est directement
disponible dans votre outil, par exemple, il existe une [extension pour
LibreOffice](https://languagetool.org/insights/fr/poste/languagetool-et-libreoffice/). Vous pouvez également
solliciter l'[API http](https://dev.languagetool.org/public-http-api) :

```bash
$ curl -d "text=This is an test." -d "language=auto" https://api.languagetool.org/v2/check
```

Vous pouvez également faire tourner localement un serveur de correction. Voir [https://dev.languagetool.org/http-server](https://dev.languagetool.org/http-server) à ce sujet.

En lançant LanguageTool en ligne de commande sur notre texte d'exemple :

```

$ java -jar languagetool-commandline.jar -l fr original.txt 

Expected text language: French
Working on original.txt...
1.) Line 1, column 30, Rule ID: ACCORD_R_PERS_VERBE[32] premium: false prio=10
Message: Vérifiez l’accord entre le sujet et le verbe « perchai ».
Suggestion: perchait
Maître Corbeau, sur un arbre perchai, Tenais en son beck un fromage. Maître Renar...
                             ^^^^^^^                                             

2.) Line 1, column 30, Rule ID: ACCORD_SUJET_VERBE[39] premium: false
Message: Un verbe conjugué à la troisième personne du singulier semble plus approprié.
Suggestion: perchait
Maître Corbeau, sur un arbre perchai, Tenais en son beck un fromage. Maître Renar...
                             ^^^^^^^                                             

3.) Line 2, column 15, Rule ID: FR_SPELLING_RULE premium: false prio=-100
Message: Faute de frappe possible trouvée.
Suggestion: bec; becs; Besse; teck; Becky
...Corbeau, sur un arbre perchai, Tenais en son beck un fromage. Maître Renard, par l'odeur alléc...
                                                ^^^^                                             

4.) Line 8, column 28, Rule ID: PRONOMS_PERSONNELS_MINUSCULE[2] premium: false
Message: La majuscule n’est employée qu’au début d’une phrase ou pour les noms propres (noms, toponymes, etc.).
Suggestion: . Vous; , vous
..., si votre ramage Se rapporte à votre plumage, Vous êtes le Phénix des hôtes de ces bois. " A ce...
                                                ^^^^^^                                             

5.) Line 10, column 1, Rule ID: A_A_ACCENT[1] premium: false prio=10
Message: La préposition « À » placée en début de phrase possède un accent grave.
Suggestion: À
...Vous êtes le Phénix des hôtes de ces bois. " A ces mots le Corbeau ne se sent pas de joie ;...
                                                ^                                             

6.) Line 11, column 30, Rule ID: PRONOMS_PERSONNELS_MINUSCULE[2] premium: false
Message: La majuscule n’est employée qu’au début d’une phrase ou pour les noms propres (noms, toponymes, etc.).
Suggestion: . Il; , il
...t pas de joie ; Et pour montrer sa belle voix, Il ouvre un large bec, laisse tomber sa proie. ...
                                                ^^^^                                             

7.) Line 13, column 27, Rule ID: ACCORD_SUJET_VERBE[35] premium: false
Message: Un verbe conjugué à la troisième personne semble plus approprié.
Suggestion: dit; disent
...e tomber sa proie. Le Renard s'en saisie, et dis : "Mon bon Monsieur, Apprené que tout flatte...
                                                ^^^                                             
More info: https://languagetool.org/insights/fr/poste/je-me-permet-ou-je-me-permets/

8.) Line 14, column 1, Rule ID: FR_SPELLING_RULE premium: false prio=-100
Message: Faute de frappe possible trouvée.
Suggestion: Apprenne; Apprend; Apprenait; Apprêté; Âpreté
...ard s'en saisie, et dis : "Mon bon Monsieur, Apprené que tout flatteur Vit aux dépens de celui qu...
                                                ^^^^^^^                                             
Time: 1551ms for 7 sentences (4.5 sentences/sec) 

```

## Intégrer un correcteur dans son IDE emacs, vim, vscode

aspell et hunspell peuvent être intégrés à [emacs](code.md) pour avoir une correction orthographique à la volée. On peut personnaliser emacs en ajoutant des commandes Lisp au fichier `~/.emacs`. Pour indiquer qu'on souhaite utiliser aspell pour vérifier l'orthographe, on ajoutera la commande:

```
(setq-default ispell-program-name "aspell")
```

On utilisera alors la correction orthographique avec les commandes ci-dessous, à exécuter dans le mini-buffer (`Meta-X`, Alt - X)

- ispell-change-dictionnary , suivi de fr ou en par exemple 
- flyspell-buffer : vérifie l'orthographe du fichier en cours d'édition
- flyspell-mode : active/désactive la correction à la volée

On fera bien attention que lorsque le dictionnaire est changé, il faut relancer la commande `flyspell-buffer` pour le prendre en compte.

Dans VIM, pour pouvoir facilement activer la correction orthographique, on peut
se définir quelques raccourcis dans son `~/.vimrc`:

```
function! ToggleSpellLang()
    " toggle between en and fr
    if &spelllang =~# 'en'
        :set spelllang=fr
    else
        :set spelllang=en
    endif
endfunction

" Note: with Byobu, press Shift-F12 to disable byobu function keys capture
nnoremap <F7> :setlocal spell!<CR> " toggle spell on or off
nnoremap <F8> :call ToggleSpellLang()<CR> " toggle language
```

ce qui permettra d'activer/désactiver la vérification orthographique avec F7, de
changer la langue avec F8. Ensuite, on passe d'une erreur à l'autre avec les
touches "[s", on obtient des suggestions de modification avec "z=". On peut
aussi intégrer LanguageTool en utilisant le plugin [ALE](https://github.com/dense-analysis/ale) ou [vim-LanguageTool](https://github.com/dpelle/vim-LanguageTool).

Sous VSCode, il semble aussi exister des extensions, par exemple [LTex+](https://marketplace.visualstudio.com/items?itemName=ltex-plus.vscode-ltex-plus) pour utiliser LanguageTool.


[^1]:
	Plus d'informations sont disponibles sur la page [http://en.wikipedia.org/wiki/Hunspell](http://en.wikipedia.org/wiki/Hunspell)
