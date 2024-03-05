# I. Service SSH

## 1. Analyse du service

🌞 **S'assurer que le service `sshd` est démarré**
```
[lionel@localhost ~]$ systemctl status
● localhost.localdomain
    State: running
    Units: 281 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Mon 2024-01-29 14:35:52 CET; 3min 32s ago
  systemd: 252-13.el9_2
   CGroup: /

              │ ├─sshd.service
           │ │ └─682 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
```

🌞 **Analyser les processus liés au service SSH**
```
[lionel@localhost ~]$ ps -ef | grep sshd
root         682       1  0 14:35 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        1306     682  0 14:37 ?        00:00:00 sshd: lionel [priv]
lionel      1310    1306  0 14:37 ?        00:00:00 sshd: lionel@pts/0
lionel      1357    1311  0 14:53 pts/0    00:00:00 grep --color=auto sshd
```

🌞 **Déterminer le port sur lequel écoute le service SSH**
```
[lionel@localhost ~]$ sudo ss -alnpt | grep sshd
LISTEN 0      128          0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=682,fd=3))
LISTEN 0      128             [::]:22           [::]:*    users:(("sshd",pid=682,fd=4))
```

🌞 **Consulter les logs du service SSH**

```
[lionel@localhost ~]$ journalctl | grep sshd
Jan 29 14:35:52 localhost systemd[1]: Created slice Slice /system/sshd-keygen.
Jan 29 14:35:53 localhost systemd[1]: Reached target sshd-keygen.target.
Jan 29 14:35:54 localhost sshd[682]: main: sshd: ssh-rsa algorithm is disabled
Jan 29 14:35:54 localhost sshd[682]: Server listening on 0.0.0.0 port 22.
Jan 29 14:35:54 localhost sshd[682]: Server listening on :: port 22.
Jan 29 14:37:40 localhost.localdomain sshd[1306]: main: sshd: ssh-rsa algorithm is disabled
Jan 29 14:37:43 localhost.localdomain sshd[1306]: Accepted password for lionel from 10.3.1.1 port 61431 ssh2
Jan 29 14:37:43 localhost.localdomain sshd[1306]: pam_unix(sshd:session): session opened for user lionel(uid=1000) by (uid=0)
```
```
[lionel@localhost log]$ sudo tail -n 10 /var/log/secure
Jan 29 15:06:02 localhost sudo[1400]: pam_unix(sudo:session): session closed for user root
Jan 29 15:08:22 localhost sudo[1407]:  lionel : TTY=pts/0 ; PWD=/var/log ; USER=root ; COMMAND=/bin/cat lastlog
Jan 29 15:08:22 localhost sudo[1407]: pam_unix(sudo:session): session opened for user root(uid=0) by lionel(uid=1000)
Jan 29 15:08:22 localhost sudo[1407]: pam_unix(sudo:session): session closed for user root
Jan 29 15:08:50 localhost sudo[1411]:  lionel : TTY=pts/0 ; PWD=/var/log ; USER=root ; COMMAND=/bin/cat sssd
Jan 29 15:08:50 localhost sudo[1411]: pam_unix(sudo:session): session opened for user root(uid=0) by lionel(uid=1000)
Jan 29 15:08:50 localhost sudo[1411]: pam_unix(sudo:session): session closed for user root
Jan 29 15:14:31 localhost sudo[1422]:  lionel : TTY=pts/0 ; PWD=/var/log ; USER=root ; COMMAND=/sbin/ss -alnpt
Jan 29 15:14:31 localhost sudo[1422]: pam_unix(sudo:session): session opened for user root(uid=0) by lionel(uid=1000)
Jan 29 15:14:31 localhost sudo[1422]: pam_unix(sudo:session): session closed for user root
```

![When she tells you](./img/when_she_tells_you.png)

## 2. Modification du service

🌞 **Identifier le fichier de configuration du serveur SSH**
```
/etc/ssh/sshd_config
```

🌞 **Modifier le fichier de conf**

```
[lionel@localhost ssh]$ echo $RANDOM
28738
``` 
```
[lionel@localhost ssh]$ sudo cat /etc/ssh/sshd_config | grep Port
Port 28738
```
```
[lionel@localhost ssh]$ sudo firewall-cmd --list-all | grep 28738
  ports: 28738/tcp
```

🌞 **Redémarrer le service**

```
[lionel@localhost ssh]$ sudo systemctl restart sshd
```

🌞 **Effectuer une connexion SSH sur le nouveau port**

```
PS C:\Users\lione> ssh lionel@10.3.1.11 -p 28738
lionel@10.3.1.11's password:
Last login: Mon Jan 29 16:48:17 2024 from 10.3.1.1
```

✨ **Bonus : affiner la conf du serveur SSH**

```
[lionel@localhost ~]$ sudo cat /etc/ssh/sshd_config | grep Root
PermitRootLogin no
```
```
[lionel@localhost ~]$ sudo cat /etc/ssh/sshd_config | grep PermitEmptyPasswords
PermitEmptyPasswords no
```
```
[lionel@localhost ~]$ sudo cat /etc/ssh/sshd_config | grep MaxAuthTries
MaxAuthTries 3
```
```
[lionel@localhost ~]$ sudo cat /etc/ssh/sshd_config | grep Client
ClientAliveInterval 300
```
```
[lionel@localhost ~]$ sudo cat /etc/ssh/sshd_config | grep PermitUser
PermitUserEnvironment no
```


- faites vos plus belles recherches internet pour améliorer la conf de SSH
- par "améliorer" on entend essentiellement ici : augmenter son niveau de sécurité
- le but c'est pas de me rendre 10000 lignes de conf que vous pompez sur internet pour le bonus, mais de vous éveiller à divers aspects de SSH, la sécu ou d'autres choses liées

![Such a hacker](./img/such_a_hacker.png)
