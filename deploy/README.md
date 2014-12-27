##Backing up Docker Containers

To backup (take a snapshot) of all active containers, run the following:

```bash
./backup_all.sh
```

Please note that if an entry exists in /tmp/DOCKER_BACKUP matching **_CONTAINER_ID:HOST_NAME:DATE_**,
the backup will be **SKIPPED**.

```bash
Backing up-> d064174dd7ad:elasticsearch-worker3:172.17.0.10
sudo docker commit d064174dd7ad eeacms/elasticsearch-worker3:20141001

Backing up-> e22c4107ff23:elasticsearch-worker2:172.17.0.9
sudo docker commit e22c4107ff23 eeacms/elasticsearch-worker2:20141001

Backing up-> bf015a0f095d:elasticsearch-worker1:172.17.0.8
sudo docker commit bf015a0f095d eeacms/elasticsearch-worker1:20141001

Backing up-> a6bc7b26ed74:elasticsearch-master:172.17.0.7
sudo docker commit a6bc7b26ed74 eeacms/elasticsearch-master:20141001

Backing up-> 4c83f2aa7918:nameserver:172.17.0.2
sudo docker commit 4c83f2aa7918 eeacms/nameserver:20141001
```

```bash
$ cat /tmp/DOCKER_BACKUP

d064174dd7ad:elasticsearch-worker3:172.17.0.10
e22c4107ff23:elasticsearch-worker2:172.17.0.9
bf015a0f095d:elasticsearch-worker1:172.17.0.8
a6bc7b26ed74:elasticsearch-master:172.17.0.7
4c83f2aa7918:nameserver:172.17.0.2
```

```bash
$ sudo docker images

REPOSITORY                         TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
eeacms/nameserver                   20141001            316e4ba56e2d        3 minutes ago       205.8 MB
eeacms/elasticsearch-master         20141001            a833c55e5774        6 minutes ago       923.7 MB
eeacms/elasticsearch-worker1        20141001            f7715f662858        9 minutes ago       11.63 GB
eeacms/elasticsearch-worker2        20141001            571861378dc8        11 minutes ago      11.11 GB
eeacms/elasticsearch-worker3        20141001            8afd67c785e3        15 minutes ago      17.68 GB

```
