## Rendu

📁 **Fichier `/srv/idcard/idcard.sh`**

🌞 **Vous fournirez dans le compte-rendu Markdown**, en plus du fichier, **un exemple d'exécution avec une sortie**

```
[lionel@localhost ~]$  /srv/idcard/idcard.sh 
Machine name: Static
OS Rocky Linux 9.2 (Blue Onyx) and kernel version is 5.14.0-284.11.1.el9_2.x86_64
ip: 10.3.1.11/24
RAM: 790244 memory available on 53876 total memory 
Disk : 4903720 space left
Top 5 processes by RAM usage :
  - .vscode-server
  - .vscode-server
  - .vscode-server
  - .vscode-server
  - python3
Listening ports :
[sudo] password for lionel: 
323 udp : chronyd
35951 tcp : node
22 tcp : sshd
PATH directories :
- /home/lionel/.vscode-server/bin/019f4d1419fbc8219a181fab7892ebccf7ee29a2/bin/remote-cli
- /home/lionel/.local/bin
- /home/lionel/bin
- /usr/local/bin
- /usr/bin
- /usr/local/sbin
- /usr/sbin
Here is your random cat (jpg file): https://cdn2.thecatapi.com/images/14g.gif
[lionel@localhost ~]$  /srv/idcard/idcard.sh 
Machine name: Static
OS Rocky Linux 9.2 (Blue Onyx) and kernel version is 5.14.0-284.11.1.el9_2.x86_64
ip: 10.3.1.11/24
RAM: 790244 memory available on 53876 total memory 
Disk : 4903720 space left
Top 5 processes by RAM usage :
  - .vscode-server
  - .vscode-server
  - .vscode-server
  - .vscode-server
  - python3
Listening ports :
323 udp : chronyd
35951 tcp : node
22 tcp : sshd
PATH directories :
- /home/lionel/.vscode-server/bin/019f4d1419fbc8219a181fab7892ebccf7ee29a2/bin/remote-cli
- /home/lionel/.local/bin
- /home/lionel/bin
- /usr/local/bin
- /usr/bin
- /usr/local/sbin
- /usr/sbin
Here is your random cat (jpg file): https://cdn2.thecatapi.com/images/264.jpg
```

## Bonus

⭐ **Bonus 1 : arguments**

- si vous avez utilisé le lien que j'ai filé pour les images de chats, on est limités à 10 requêtes avant de devoir créer un compte
- créer un compte, ça donne un token
- ajoutez la possibilité de passer le token en argument

C'est à dire :

```bash
$ /srv/idcard/idcard.sh live_gxXl7Z0PjPMFVDdIM77T2c6beemFCHy8KRimDi0BGwZVOIqwCHbksr2Bva8VWUUV 
[...]
Here is your random cat (jpg file) : ./cat.jpg
```

Si aucun token est précisé, il y en a un par défaut qui est utilisé et c'est affiché dans la sortie :

```bash
$ /srv/idcard/idcard.sh  
[...]
Here is your random cat (jpg file) : ./cat.jpg (using default token)
```

⭐ **Bonus 2 : votre script doit s'exécuter en `root`**

> Vous apprend à mieux gérer vos permissions : un script donné qui a un but donné, c'est une bonne pratique que de créer un utilisateur dédié. Ainsi, on limite les privilèges donnés au script pendant son exécution.

- si le script est lancé avec un autre user que `root`, il quitte
  - vous pouvez utiliser la commande 🐚 `exit` pour que le script s'arrête
  - c'est obligatoire pour que la commande `ss` fonctionne comme attendu

---

⭐ **Bonus 3 : l'image du chat est téléchargée sur la machine**

> *Nécessite d'avoir fait le bonus 2. Vous apprend à gérer un téléchargement HTTP et quelques tricks shell en + pour la gestion d'ID.*

- **dans le dossier `/srv/cats/`**
  - le script quitte si ce dossier n'existe pas
- **le dossier `/srv/cats/` doit appartenir à l'utilisateur `id`**
  - le script quitte si c'est pas le cas
- **le dossier `/srv/cats/` doit être *writable* pour l'utilisateur `id`**
  - sinon il pourrait pas créer de fichiers dedans...
  - le script quitte si c'est pas le cas
- **renommer l'image avec un id**
  - l'image est renommée `1.jpg` pour la première image, puis `2.jpg` pour la deuxième, etc.
  - à chaque fois qu'on appelle le script, faut donc déterminer quel numéro est le prochain
  - gérer les IDs vaquants
    - si on télécharge 3 photos, mais qu'on supprime `2.jpg`, la prochaine photo téléchargée devra s'appeler `2.jpg`
    - on récupère l'ID vaquant `2` qui avait été libéré

---

⭐ **Bonus 4 : afficher + d'infos**

> *Vous demande d'aller creuser un peu plus et au passage apprendre un peu plus sur la façon dont l'OS fonctionne. Petit bout par petit bout.*

En plus des infos que votre script `/srv/idcard/idcard.sh` affiche déjà, ajoutez les infos suivantes :

- nombre d'inodes dispos sur la partition montée sur `/` et nombre total possible
  - afficher sous la forme :

```bash
$ /srv/idcard/idcard.sh
[...]
inodes on / partition : xxx/yyy
# où `xxx` c'est le nombre dispo et `yyy` le nombre total dans votre affichage
[...]
```

- liste des fichiers qui sont en SUID `root` sur la machine
  - afficher sous la forme :

```bash
$ /srv/idcard/idcard.sh
[...]
SUID files :
  - /path/to/suid
  - ...
[...]
```

- vérifier que la connexion en SSH en root est désactivée
  - il faut regarder le contenu du fichier de conf du serveur SSH pour ça
  - y'a une ligne qui permet d'autoriser ou non la connexion en root
  - afficher sous la forme :

```bash
$ /srv/idcard/idcard.sh
[...]
SSH root connection enabled : yes/no
# affiche seulement yes ou seulement no chez vous, en fonction de si c'est activé ou non
[...]
```
