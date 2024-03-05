# Partie 2 : Programmes et paquets
# I. Programmes et processus

## 1. Run then kill

🌞 **Lancer un processus `sleep`**
```
[marmotte@localhost ~]$ ps -h | grep sleep
   2278 pts/0    S+     0:00 sleep 1000

   PID : 2278
```

🌞 **Terminez le processus `sleep` depuis le deuxième terminal**
```
[marmotte@localhost ~]$ kill 2278
```

## 2. Tâche de fond

🌞 **Lancer un nouveau processus `sleep`, mais en tâche de fond**
```
[marmotte@localhost ~]$ sleep 1000 &
[1] 2290
```

🌞 **Visualisez la commande en tâche de fond**
```
[marmotte@localhost ~]$ ps -e | grep sleep
   2309 pts/0    00:00:00 sleep
```

## 3. Find paths

🌞 **Trouver le chemin où est stocké le programme `sleep`**
```
ls -al /usr/bin/ | grep sleep
```

🌞 Tant qu'on est à chercher des chemins : **trouver les chemins vers tous les fichiers qui s'appellent `.bashrc`**
```
[lionel@localhost ~]$ sudo find / -name .bashrc
[sudo] password for lionel:
/etc/skel/.bashrc
/root/.bashrc
/home/lionel/.bashrc
/home/papier_alu/.bashrc
```

## 4. La variable PATH

🌞 **Vérifier que**
```
[lionel@localhost ~]$ echo $PATH
/home/lionel/.local/bin:/home/lionel/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
[lionel@localhost ~]$ which sleep ssh ping
/usr/bin/sleep
/usr/bin/ssh
/usr/bin/ping
```
# II. Paquets

➜ **Tous les OS Linux sont munis d'un store d'application**

🌞 **Installer le paquet `firefox`**
```
sudo dnf install git -y
```
🌞 **Utiliser une commande pour lancer Firefox**
```
[lionel@localhost ~]$ which git
/usr/bin/git
```

🌞 **Installer le paquet `nginx`**
```
sudo dnf install nginx
```

🌞 **Déterminer**
```
[lionel@localhost]$ sudo cat /var/log/dnf.log
[lionel@localhost nginx]$ sudo cat /etc/nginx/nginx.conf
```
🌞 **Mais aussi déterminer...**

```
[lionel@localhost yum.repos.d]$ grep -nr -E '^mirrorlist'
rocky-addons.repo:13:mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=HighAvailability-$releasever$rltype
rocky-addons.repo:23:mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=HighAvailability-$releasever-debug$rltype
rocky-addons.repo:32:mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=HighAvailability-$releasever-source$rltype
rocky-addons.repo:41:mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=ResilientStorage-$releasever$rltype
rocky-addons.repo:51:mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=ResilientStorage-$releasever-debug$rltype
```
