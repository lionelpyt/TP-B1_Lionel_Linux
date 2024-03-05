# Partie : Files and users

# I. Fichiers

## 1. Find me

🌞 **Trouver le chemin vers le répertoire personnel de votre utilisateur**
```
[lionel@localhost /]$ cd /home/lionel/
```

🌞 **Trouver le chemin du fichier de logs SSH**
```
[lionel@localhost]$ sudo cat /var/log/secure
Nov  9 14:42:24 localhost sshd[683]: Server listening on 0.0.0.0 port 22.
Nov  9 14:42:24 localhost sshd[683]: Server listening on :: port 22.
Nov  9 14:42:37 localhost systemd[1267]: pam_unix(systemd-user:session): session opened for user lionel(uid=1000) by (uid=0)
Nov  9 14:42:37 localhost login[690]: pam_unix(login:session): session opened for user lionel(uid=1000) by LOGIN(uid=0)
Nov  9 14:42:37 localhost login[690]: LOGIN ON tty1 BY lionel
```

🌞 **Trouver le chemin du fichier de configuration du serveur SSH**

```
[lionel@localhost /]$ sudo cat /etc/ssh/sshd_config
#       $OpenBSD: sshd_config,v 1.104 2021/07/02 05:11:21 dtucker Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
```

# II. Users

## 1. Nouveau user

🌞 **Créer un nouvel utilisateur**

```
[lionel@localhost /]$ sudo adduser marmotte
[sudo] password for lionel:
[lionel@localhost /]$ sudo passwd marmotte
Changing password for user marmotte.
New password:
BAD PASSWORD: The password fails the dictionary check - it is based on a dictionary word
Retype new password:
passwd: all authentication tokens updated successfully.

[lionel@localhost ~]$ sudo usermod -d /home/papier_alu -m marmotte
```

## 2. Infos enregistrées par le système

➜ **Pour le compte-rendu**, et pour vous habituer à **utiliser le terminal de façon pratique**, petit hint :

```bash
# supposons un fichier "nul.txt", on peut afficher son contenu avec la commande :
$ cat /chemin/vers/nul.txt
salut
à
toi

# il est possible en une seule ligne de commande d'afficher uniquement une ligne qui contient un mot donné :
$ cat /chemin/vers/nul.txt | grep salut
salut

# à l'aide de `| grep xxx`, on a filtré la sortie de la commande cat
# ça n'affiche donc que la ligne qui contient le mot demandé : "salut"
```

🌞 **Prouver que cet utilisateur a été créé**

```
[lionel@localhost home]$ cat /etc/passwd | grep marmotte
marmotte:x:1001:1001::/home/papier_alu:/bin/bash
```

🌞 **Déterminer le *hash* du password de l'utilisateur `marmotte`**
```
[lionel@localhost home]$ sudo cat /etc/shadow | grep marmotte
marmotte:$6$4suPdsBvxvXJLS73$JRslFxTX6g4jtEDxPaM7GL279ZWxNEXU0hu/pPBWNKKkSa66S9rIVERfxCzXpRQe/o3g9te.f5snpwlObg.CP/:19744:0:99999:7:::
```

## 3. Hint sur la ligne de commande

## 3. Connexion sur le nouvel utilisateur

🌞 **Tapez une commande pour vous déconnecter : fermer votre session utilisateur**
```
[lionel@localhost home]$ exit
logout
Connection to 10.3.1.11 closed.
```

🌞 **Assurez-vous que vous pouvez vous connecter en tant que l'utilisateur `marmotte`**

```
[marmotte@localhost ~]$ ls /home/lionel
ls: cannot open directory '/home/lionel': Permission denied
```

