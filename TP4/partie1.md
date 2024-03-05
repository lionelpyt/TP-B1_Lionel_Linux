🌞 **Partitionner le disque à l'aide de LVM**

```
[lionel@localhost ~]$ sudo pvcreate /dev/sdb
  Physical volume "/dev/sdb" successfully created.
[lionel@localhost ~]$ sudo pvcreate /dev/sdc
  Physical volume "/dev/sdc" successfully created.
``` 
```
[lionel@localhost ~]$ sudo vgcreate storage /dev/sdb
[sudo] password for lionel:
  Volume group "storage" successfully created
```
```
[lionel@localhost ~]$ sudo vgextend storage /dev/sdc
  Volume group "storage" successfully extended
```
```
[lionel@localhost ~]$ sudo lvcreate -l 100%FREE storage -n last_data
  Logical volume "last_data" created.
```

🌞 **Formater la partition**
```
[lionel@localhost ~]$ sudo mkfs -t ext4 /dev/storage/last_data
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 1046528 4k blocks and 261632 inodes
```

🌞 **Monter la partition**
```
[lionel@localhost storage]$ df -h | grep storage
/dev/mapper/storage-last_data  3.9G   24K  3.7G   1% /mnt/storage
```

```
[lionel@localhost ~]$ sudo dd if=/dev/random of=/mnt/storage/test bs=5M count=5
5+0 records in
5+0 records out
26214400 bytes (26 MB, 25 MiB) copied, 0.0674955 s, 388 MB/s
```
```
[lionel@localhost ~]$ sudo tail -n 1 /mnt/storage/test
���v����*Ob�iH.��� 9r��/�����T��(���S�������V���_�ޙ=h�3�4�?ĝ��J�71+Gx2� <Gƽ"�]��5Tr��+���N�
```
- définir un montage automatique de la partition (fichier `/etc/fstab`)
  - vous vérifierez que votre fichier `/etc/fstab` fonctionne correctement

Ok ! Za, z'est fait. On a un espace de stockage dédié pour stocker nos sites web.

⭐**BONUS**

- utilisez une commande `dd` pour remplir complètement la nouvelle partition
- prouvez que la partition est remplie avec une commande `df`
- ajoutez un nouveau disque dur de 2G à la machine
- ajoutez ce new disque dur à la conf LVM
- agrandissez la partition pleine à l'aide du nouveau disque
- prouvez aavec un `df` que la partition a bien été agrandie

**Passons à [la partie 2 : installation du serveur de partage de fichiers](./../part2/README.md).**

