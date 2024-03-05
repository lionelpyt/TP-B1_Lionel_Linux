# II. Service HTTP

## 1. Mise en place

🌞 **Installer le serveur NGINX**
```
[lionel@localhost ~]$ sudo dnf install nginx
[sudo] password for lionel:
Rocky Linux 9 - BaseOS                                                402  B/s | 4.1 kB     00:10
Rocky Linux 9 - BaseOS                                                141 kB/s | 2.2 MB     00:15
Rocky Linux 9 - AppStream                                             449  B/s | 4.5 kB     00:10
Rocky Linux 9 - AppStream                                             471 kB/s | 7.4 MB     00:16
Rocky Linux 9 - Extras                                                292  B/s | 2.9 kB     00:10
Rocky Linux 9 - Extras                                                905  B/s |  14 kB     00:15
Dependencies resolved.
```

🌞 **Démarrer le service NGINX**
```
[lionel@localhost ~]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
     Active: active (running) since Tue 2024-01-30 15:23:54 CET; 34s ago
```
🌞 **Déterminer sur quel port tourne NGINX**
```
[lionel@localhost ~]$ sudo ss -alnpt | grep nginx
LISTEN 0      511             [::]:80            [::]:*    users:(("nginx",pid=11219,fd=7),("nginx",pid=11218,fd=7))
```

🌞 **Déterminer les processus liés au service NGINX**
```
[lionel@localhost ~]$ ps -ef | grep nginx
root       11218       1  0 15:23 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx      11219   11218  0 15:23 ?        00:00:00 nginx: worker process
lionel     11285    1296  0 15:39 pts/0    00:00:00 grep --color=auto nginx
```

🌞 **Déterminer le nom de l'utilisateur qui lance NGINX** 
```
[lionel@localhost ~]$ sudo cat /etc/passwd | grep root
root:x:0:0:root:/root:/bin/bash
```


🌞 **Test !**
```
[lionel@localhost ~]$ curl http://10.3.1.11:80  2> /dev/null | head -n7
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
```

## 2. Analyser la conf de NGINX

🌞 **Déterminer le path du fichier de configuration de NGINX**
```
[lionel@localhost conf.d]$ ls -al /etc/nginx/nginx.conf
-rw-r--r--. 1 root root 2334 Oct 16 20:00 /etc/nginx/nginx.conf
```

🌞 **Trouver dans le fichier de conf**

```
[lionel@localhost conf.d]$ sudo cat /etc/nginx/nginx.conf | grep server -A 5
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;
```
```
[lionel@localhost conf.d]$ sudo cat /etc/nginx/nginx.conf | grep include
include /usr/share/nginx/modules/*.conf;
    include             /etc/nginx/mime.types;
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/default.d/*.conf;
#        include /etc/nginx/default.d/*.conf;
```

## 3. Déployer un nouveau site web

🌞 **Créer un site web**
```
 sudo mkdir -p /var/www/tp3_linux && echo "<h1>MEOW mon premier serveur web</h1>" | sudo tee /var/www/tp
3_linux/index.html
```

🌞 **Gérer les permissions**

```
[lionel@localhost tp3_linux]$ sudo chown root /var/www/tp3_linux
```

🌞 **Adapter la conf NGINX**

- dans le fichier de conf principal
  - vous supprimerez le bloc `server {}` repéré plus tôt pour que NGINX ne serve plus le site par défaut
  - redémarrez NGINX pour que les changements prennent effet
  
- créez un nouveau fichier de conf
  - il doit être nommé correctement
  - il doit être placé dans le bon dossier
  - c'est quoi un "nom correct" et "le bon dossier" ?
    - bah vous avez repéré dans la partie d'avant les fichiers qui sont inclus par le fichier de conf principal non ?
    - créez votre fichier en conséquence
  - redémarrez NGINX pour que les changements prennent effet
  - le contenu doit être le suivant :

```nginx
server {
  # le port choisi devra être obtenu avec un 'echo $RANDOM' là encore
  listen <PORT>;

  root /var/www/tp3_linux;
}
```

🌞 **Visitez votre super site web**

- toujours avec une commande `curl` depuis votre PC (ou un navigateur)

