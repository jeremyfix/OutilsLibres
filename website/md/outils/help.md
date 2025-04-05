# Obtenir de l'aide sur les outils

Pour obtenir de l'aide sur une commande, vous pouvez bien sûr utiliser un moteur
de recherche, explorer des forums comme [https://stackoverflow.com](https://stackoverflow.com) mais il existe également quelques commandes :

- `man` vous donne accès au manuel sur une commande, 
- `info` a vocation à succéder à `man` et est une documentation plus complète du
  projet GNU
- `tldr` (Too Long Don't Read) documente une commande en montrant comment l'utiliser

Par exemple:

```
$ man wget

WGET(1)                                                                                 GNU Wget                                                                                WGET(1)

NAME
       Wget - The non-interactive network downloader.

SYNOPSIS
       wget [option]... [URL]...

DESCRIPTION
       GNU Wget is a free utility for non-interactive download of files from the Web.  It supports HTTP, HTTPS, and FTP protocols, as well as retrieval through HTTP proxies.

       Wget is non-interactive, meaning that it can work in the background, while the user is not logged on.  This allows you to start a retrieval and disconnect from the system,
       letting Wget finish the work.  By contrast, most of the Web browsers require constant user's presence, which can be a great hindrance when transferring a lot of data.

       Wget can follow links in HTML, XHTML, and CSS pages, to create local versions of remote web sites, fully recreating the directory structure of the original site.  This is
       sometimes referred to as "recursive downloading."  While doing that, Wget respects the Robot Exclusion Standard (/robots.txt).  Wget can be instructed to convert the links in
       downloaded files to point at the local files, for offline viewing.

       Wget has been designed for robustness over slow or unstable network connections; if a download fails due to a network problem, it will keep retrying until the whole file has
       been retrieved.  If the server supports regetting, it will instruct the server to continue the download from where it left off.

```

```
$ info coreutils

Next: Introduction,  Up: (dir)

GNU Coreutils
*************

This manual documents version 8.32 of the GNU core utilities, including
the standard programs for text and file manipulation.

   Copyright © 1994-2020 Free Software Foundation, Inc.

     Permission is granted to copy, distribute and/or modify this
     document under the terms of the GNU Free Documentation License,
     Version 1.3 or any later version published by the Free Software
     Foundation; with no Invariant Sections, with no Front-Cover Texts,
     and with no Back-Cover Texts.  A copy of the license is included in
     the section entitled “GNU Free Documentation License”.

* Menu:

* Introduction::                 Caveats, overview, and authors
* Common options::               Common options
* Output of entire files::       cat tac nl od base32 base64 basenc
* Formatting file contents::     fmt pr fold
....

```

```
$ tldr wget
 wget

  Download files from the Web.
  Supports HTTP, HTTPS, and FTP.
  More information: https://www.gnu.org/software/wget.

  - Download the contents of a URL to a file (named "foo" in this case):
    wget https://example.com/foo

  - Download the contents of a URL to a file (named "bar" in this case):
    wget --output-document bar https://example.com/foo

  - Download a single web page and all its resources with 3-second intervals between requests (scripts, stylesheets, images, etc.):
    wget --page-requisites --convert-links --wait 3 https://example.com/somepage.html

  - Download all listed files within a directory and its sub-directories (does not download embedded page elements):
    wget --mirror --no-parent https://example.com/somepath/

  - Limit the download speed and the number of connection retries:
    wget --limit-rate 300k --tries 100 https://example.com/somepath/

  - Download a file from an HTTP server using Basic Auth (also works for FTP):
    wget --user username --password password https://example.com

  - Continue an incomplete download:
    wget --continue https://example.com

  - Download all URLs stored in a text file to a specific directory:
    wget --directory-prefix path/to/directory --input-file URLs.txt

Found 1 page with the same name under the platform: windows.
```
