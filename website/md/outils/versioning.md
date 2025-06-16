# Versionner du code (git, github, gitlab)

Aujourd'hui, plus personne ne (devrait) développe(r) du code sans utiliser un
[outil de versionning](https://en.wikipedia.org/wiki/List_of_version-control_software). Le versionning, qu'il soit local à votre machine et
utilisant un serveur distant (**remote**) vous permet de garder une trace de
l'historique de votre code. 

Les outils de versionning permettent plus précisémment :

- d'enregistrer des versions spécifiques de votre code (**commit**),
- de naviguer dans l'historique de votre (**checkout**)
- de développer des fonctionnalités en parallèle (**branche**)
- d'intégrer des modifications d'une branche A dans une branche B via des
  mécanismes tels que les **rebase** ou les **merge**


Le versioning peut se faire en local ou utiliser un serveur. L'outil de
versionning le plus utilisé aujourd'hui est très probablement [git](https://git-scm.com/), open-source et développpé initialement par Linus Torvals. Parmi les plateformes en ligne utilisant git comme outil de gestion de version, on peut citer :

- [https://www.github.com](https://www.github.com) : plateforme propriétaire développée et
  maintenue par Microsoft
- [https://www.gitlab.com](https://www.gitlab.com) : plateforme open-source qui peut être
  auto-hébergée. Beaucoup d'organisations disposent de leurs propres instances
  gitlab, comme [https://gitlab.inria.fr](https://gitlab.inria.fr),
  [https://gitlab-student.centralesupelec.fr](https://gitlab-student.centralesupelec.fr),
  [https://framagit.org](https://framagit.org), ...

L'avantage d'utiliser des plateformes en ligne est qu'elles permettent le
développement collaboratif. Par exemple, le noyau linux est hébergé sur un dépôt
github : [https://github.com/torvalds/linux](https://github.com/torvalds/linux). 

Les plateformes telles que gitlab et github viennent par ailleurs avec un
certain nombre d'autres fonctionnalités absolument géniales. Elles vont porter
des noms différents d'une plateforme à l'autre mais vous pouvez par exemple: 

- créer des **issues**, c'est à dire des notes qui signalent aux développeurs des bugs, des
  améliorations souhaitées, etc... . Ce sont des fils de discussion sur un sujet
  particulier
- créer des **pull requests**, c'est à dire des propositions de modification de
  la base de code,
- déclencher des séquences d'actions : des **Actions** sur github, ou du
  **CI/CD** sur gitlab

Le dernier point fait référence aux mécanismes d'intégration et de déploiement
continue (ce que github appelle des Actions). C'est un mécanisme extrêmement
puissant qui va vous permettre de déclencher du code sous certaines conditions.
Quelques cas d'usage :

- lancer des tests unitaires dès qu'une **pull request** est créée,
- livrer automatiquement sur [https://pypi.org](https://pypi.org) un package
  python lorsqu'une nouvelle release est créée,
- compiler et mettre en ligne automatiquement une documentation écrite avec
  mkdocs, jekyll, hugo ou autre,
- ...

Vous pouvez également déclencher des signaux (**trigger**) qui vont déclencher
des **pipelines** d'intégration et développement continus sur d'autres dépôts.
Ce mécanisme est absolument génial, vraiment.

Pour apprendre git, plusieurs ressources sont disponibles :

- le tutorial d'Hervé Frezza-Buet : [https://fix_jer.pages.centralesupelec.fr/tutorials/TPs/GIT/](https://fix_jer.pages.centralesupelec.fr/tutorials/TPs/GIT/),
- un tutoriel interactif sur les commits, branchements, etc sur [https://learngitbranching.js.org/](https://learngitbranching.js.org/)
- des explications visuelles des différents concepts liés à git sur [https://marklodato.github.io/visual-git-guide/index-en.html](https://marklodato.github.io/visual-git-guide/index-en.html)
- des explications visuelles dynamiques des concepts lié sà git sur [https://onlywei.github.io/explain-git-with-d3/](https://onlywei.github.io/explain-git-with-d3/)

Pour ce qui est d'écrire des pipelines d'intégration et de développement
continue, je n'ai pas pour le moment de tutoriels à vous suggérer.
