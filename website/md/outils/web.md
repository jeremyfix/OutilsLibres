# Produire un site web, par exemple de documentation (mkdocs, jekyll, hugo)

Que ce soit pour partager ses projets, publications,
etc.. ou pour la création d'une documentation pour un logiciel que vous
développez, vous pourriez avoir besoin de développer un site web. 

Une manière de procéder, plutôt que d'écrire soit même les balises HTML est
d'écrire le contenu de son site en Markdown et d'utiliser un générateur de site
transformer les fichiers markdown en pages HTML. Et, cerise sur le gâteau, en
hébergeant les fichiers Markdown sur un serveur gitlab ou sur github, vous
pouvez coupler votre dépôt à de l'intégration continue/déploiement continu
(CI/CD) pour que la production des pages HTML et la mise en ligne du site se
fasse de manière automatique.

Plusieurs possibilités s'offrent à vous, parmi les plus populaires en ce moment
: [mkdocs](https://www.mkdocs.org/), [jekyll](https://www.mkdocs.org/) ou encore [hugo](https://gohugo.io/). 

Les pages que vous êtes entrain de regarder sont générées avec Mkdocs :

- les pages sont hébergées sur github sur le dépôt [https://github.com/jeremyfix/OutilsLibres](https://github.com/jeremyfix/OutilsLibres)
- le site est composé du fichier de configure [mkdocs.yml](https://github.com/jeremyfix/OutilsLibres/blob/master/website/conf/mkdocs.yml) et le contenu du site comprends des fichiers markdown, par exemple [web.md](https://github.com/jeremyfix/OutilsLibres/blob/master/website/md/outils/web.md), d'images, de scripts javascripts, etc...
- la construction du site statique et la mise en ligne est réalisée par les
  actions github définies dans le fichier [.github/workflows/mkdocs.yml](https://github.com/jeremyfix/OutilsLibres/blob/master/.github/workflows/mkdocs.yml)

Dès lors qu'une modification du contenu du site est "pushée" sur le dépôt,
l'intégration s'occupe de construire le site et de le mettre en ligne.

## Configuration

Il est très facile de construire rapidement un site avec mkdocs. Regardez le
[getting started](https://www.mkdocs.org/getting-started/). Une fois la mise en
place réalisée, vous pouvez construire localement le site avec

```bash
$ mkdocs serve
```

Si vous voulez ajouter des choses particulières, il y a un peu de configuration initiale à mettre en place que l'on retrouve dans
le fichier [mkdocs.yml](https://github.com/jeremyfix/OutilsLibres/blob/master/website/conf/mkdocs.yml). En particulier :

- repo_url et site_url permettent de faire apparaître l'icone et le lien vers le dépôt
  github en haut de page
- theme permet de configurer le thème de vos pages. Ici, on a choisi [Material
  for MkDocs](https://squidfunk.github.io/mkdocs-material/reference/)
- markdown_extensions liste les extensions utilisées, plusieurs étant issues de
  la documentation de Material for MkDocs pour ajouter la coloration syntaxique
  du code, transformer les équations Mathématiques avec Mathjax, etc..

```yaml
site_name: Les outils du logiciel libre pour l'ingénieur
docs_dir: ../md
repo_url: https://github.com/jeremyfix/OutilsLibres
site_url: https://jeremyfix.github.io/OutilsLibres
theme: 
  name: material
  language: fr
  features:
    - navigation.sections
    - toc.follow
    - toc.integrate

  palette:
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: amber
...

```

