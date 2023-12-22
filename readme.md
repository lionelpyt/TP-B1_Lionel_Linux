# TP1 : Casser avant de construire

**Dans ce TP on va casser des VMs.**

Pour le plaisir ("for fun and profit" comme on dit) mais aussi pour :

- vous pousser à explorer l'environnement par vous-mêmes
- appréhender par vous-mêmes le début de certaines notions
- vous rendre compte qu'on casse pas une machine par hasard, et donc ne pas avoir peur de taper des commandes !

Au début je vous indique des façons de casser la machine, et dans un deuxième temps, je vous laisse être créatifs pour trouver par vos propres moyens d'autres façons de péter la machine.

## Sommaire

- [TP1 : Casser avant de construire](#tp1--casser-avant-de-construire)
  - [Sommaire](#sommaire)
- [I. Setup](#i-setup)
- [II. Casser](#ii-casser)
  - [1. Objectif](#1-objectif)
  - [2. Fichier](#2-fichier)
  - [3. Utilisateurs](#3-utilisateurs)
  - [4. Disques](#4-disques)
  - [5. Malware](#5-malware)
  - [6. You own way](#6-you-own-way)

# I. Setup

➜ **Machine virtuelle avec un OS Linux**

- l'OS de votre choix (Rocky Linux ou autre chose)

➜ **Accès à un terminal sur la machine**

- avec une session SSH
- ou directement l'interface de la VM si ça vous convient

➜ **Effectuer un snapshot**

- c'est une fonctionnalité de VirtualBox (ou de n'importe quel autre hyperviseur)
- ça permet de faire un "instantané" d'une VM à un instant T
- on peut, plus tard, restaurer la VM dans cet état
- je vous recommande donc de faire un snapshot de votre VM avant de la détruire
- comme ça, vous pouvez revenir en arrière, avant qu'elle soit cassée pour continuer à bosser

# II. Casser

## 1. Objectif

➜ **Vous devez rendre la VM inutilisable. Par inutilisable on entend :**

- elle ne démarre (boot) même plus
- ça boot, mais on ne peut plus se connecter de aucune façon
- ça boot, on peut se co, mais on arrive sur un environnement tellement dégradé qu'il est pas utilisable

![Dead yet ?](./img/dead_yet.gif)

➜ **Tout doit être fait depuis le terminal de la VM**

> Si vous avez des doutes sur la validité de votre cassage, demandez-moi !

## 2. Fichier

🌞 **Supprimer des fichiers**
```
sudo rm -r /usr/bin/bash
```

## 3. Utilisateurs

🌞 **Mots de passe**
```
[lionel@localhost ~]$ sudo awk -F: '($3 >= 1000) {print $1}' /etc/passwd | xargs -I {} sudo sh -c 'echo "{}:motdepasse" | chpasswd'
```

🌞 **Another way ?**
```
sudo awk -F: '($3 >= 1000) {print $1}' /etc/passwd | xargs -I {} sudo usermod -L {}
```

## 4. Disques

🌞 **Effacer le contenu du disque dur**
```
sudo dd if=/dev/zero of=/dev/sda bs=1M
```

## 5. Malware

🌞 **Reboot automatique**

- faites en sorte que si un utilisateur se connecte, ça déclenche un reboot automatique de la machine

## 6. You own way

🌞 **Trouvez 4 autres façons de détuire la machine**

- tout doit être fait depuis le terminal de la machine
- pensez à ce qui constitue un ordi/un OS
- l'idée c'est de supprimer des trucs importants, modifier le comportement de trucs existants, surcharger tel ou tel truc...

![Boom](./img/cat_boom.gif)