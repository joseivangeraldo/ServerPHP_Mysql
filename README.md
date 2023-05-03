## LAMP Server Apache: Montado em um Docker Container

### Recursos Necessarios

* [Docker Hub:](https://hub.docker.com/)
* [Apache Docker Imagem oficial:](https://hub.docker.com/_/httpd)
* [Mysql Docker imagem oficial:](https://hub.docker.com/_/mysql)
* [Documentação PHP:](https://www.php.net)
* [PHPMyadmin Docker imagem oficial:](https://hub.docker.com/_/phpmyadmin)

version: '3' 
 services: 
   db: 
     image: mysql:latest 
     environment: 
       MYSQL_DATABASE: lamp_demo 
       MYSQL_USER: lamp_demo 
       MYSQL_PASSWORD: password 
       MYSQL_ALLOW_EMPTY_PASSWORD: 1 
     volumes: 
       - "./db:/docker-entrypoint-initdb.d" 
     networks: 
       - lamp-docker 
   www: 
     depends_on: 
       - db 
     image: php:8.1.1-apache 
     volumes: 
       - "./:/var/www/html" 
     ports: 
       - 80:80 
       - 443:443 
     networks: 
       - lamp-docker 
   phpmyadmin: 
     depends_on: 
       - db 
     image: phpmyadmin/phpmyadmin 
     ports: 
       - 8001:80 
     environment: 
       - PMA_HOST=db 
       - PMA_PORT=3306 
     networks: 
       - lamp-docker 
 networks: 
   lamp-docker: 
     driver: bridge


gitpod /workspace/DevOps (main) $ git init
Reinitialized existing Git repository in /workspace/DevOps/.git/
gitpod /workspace/DevOps (main) $ git add .
gitpod /workspace/DevOps (main) $ git commit "Alterado e acrescentado"
error: pathspec 'Alterado e acrescentado' did not match any file(s) known to git
gitpod /workspace/DevOps (main) $ git commit -m "Alterado e acrescentado"
[main f16ac4a] Alterado e acrescentado
 7 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 Comandos_Git.txt
 create mode 100644 Lamp-Server/anotacoes.txt
 create mode 100644 Lamp-Server/db/dump.sql
 create mode 100644 Lamp-Server/php_info.php
 create mode 100644 docker-composeHelp.txt
 delete mode 100644 teste.txt
gitpod /workspace/DevOps (main) $ git push 
Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 16 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (9/9), 2.64 KiB | 2.64 MiB/s, done.
Total 9 (delta 0), reused 0 (delta 0), pack-reused 0
To https://gitlab.com/devops1960215/DevOps.git
   6b32193..f16ac4a  main -> main
gitpod /workspace/DevOps (main) $ 




###########COMANDOS git #####################
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ git config --global user.name "joseivangeraldo"
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ echo $?

@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ git init
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ git add 1.html
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ git add .
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ git commit -m “Mensagem”
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ git config --global user.email "ivan.geraldo@gmail.com


$ uname -r  → Ver sistema
$ cat /etc/os-release → Ver dados do Sistema 







$ git init
$ docker images

$ docker run -it -d ubuntu
$ docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
bdbe65559ed2   ubuntu    "/bin/bash"   23 seconds ago   Up 23 seconds             pedantic_lehmann
$ docker stop bdbe65559ed2


$ docker ps -a
$ docker ps
$ docker exec -it c101bde68316 bash

$ docker run -ti -d ubuntu → BAIXA DO DOCKERHUB E JÁ FICA EM RUN

$ docker commit 0ce0075abf59 test → Grava mudanças no container_ID cria uma outra Imagem 
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
test         latest    92338967288c   26 seconds ago   77.8MB


$ docker run -it -d ubuntu
c35c1d1c4cdc8f734f00742de9e9e77112946a1a3d133d777edb7d5b36bdee7c
$ docker exec -it c35c1d1c4cdc8f734f00742de9e9e77112946a1a3d133d777edb7d5b36bdee7c bash


root@c35c1d1c4cdc:/# apt-get update    
root@c35c1d1c4cdc:/# apt-get install apache2
root@c35c1d1c4cdc:/# service apache2 status
 * apache2 is not running

root@c35c1d1c4cdc:/# service apache2 start
 * apache2 is running

$ docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
c35c1d1c4cdc   ubuntu    "/bin/bash"   10 minutes ago   Up 10 minutes             youthful_snyder
$ docker commit c35c1d1c4cdc ivan/apache
Sha256:69cb796b8cab5c68c861889771782f2d056ad1d21e474c9aa97f10bb7ee6da2e

docker run -it -p 82:80 -d ivan/apache  —> PARA MAPAEAR AS PORTAS USA 82 da maquina, 80 do docker
root@b4e7e3fce777:/# service apache2 start

#########     CARREGAR PARA DOCKERHUB      ##################################
$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
ivan/apache   latest    9402b17caf8c   47 minutes ago   286MB

$ docker tag ivan/apache:latest joseivangeraldo/apacheserver:v1
gitpod /workspace/DevOpsTraining (main) $ docker images
REPOSITORY                     TAG       IMAGE ID       CREATED          SIZE
ivan/apache                    latest    9402b17caf8c   50 minutes ago   286MB
joseivangeraldo/apacheserver   v1        9402b17caf8c   50 minutes ago   286MB
joseivangeraldo                latest    9402b17caf8c   50 minutes ago   286MB

$ docker login
Login Succeeded
$ docker push joseivangeraldo/apacheserver:v1


Dockerfile:



#############CRIAR O ARQUIVO DOCKERFILE ######################
FROM ubuntu  → pega a imagem do ubuntu
RUN apt-get update   → atualiza o sistema
RUN apt-get -y install apache2   → faz a instalação automatica
ADD . /var/www/html → adiciona um diretorio a maquina local
ENTRYPOINT apachectl -D FOREGROUND   → Ele ja Inicia o Apache
ENV name Intelipaat  → cria a variavel de ambiente
CONSTRUINDO A DOCKER IMAGE
$ docker build . -t new_dockerfile
###################################################################

$ docker images
$ docker run -it -p 84:80 -d new_dockerfile
f7eb2a9a276b066c0ead0a87c8fcf5f988bc249abc88653412919a00a027fb79
$ docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED         STATUS         PORTS                               NAMES
f7eb2a9a276b   new_dockerfile   "/bin/sh -c 'apachec…"   8 seconds ago   Up 8 seconds   0.0.0.0:84->80/tcp, :::84->80/tcp   mystifying_haibt
root@f7eb2a9a276b:/# echo $name
Intelipaat   —> Aqui aparece o nome da seção que criei no Dockerfile 



#### Docker volume Maps ##########
###### TIPO BIND MOUNTING ###########################
$ docker run -it -v /workspaces/DevOpsTraining/dockerfile:/app -d new_dockerfile
workspaces/DevOpsTraining/dockerfile : MINHA PASTA MAQUINA LOCAL 
/app : NOME DA PASTA PARA MONTAR NO CONTAINER
New_dockerfile : MINHA IMAGEM

@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker images
REPOSITORY       TAG       IMAGE ID       CREATED       SIZE
new_dockerfile   latest    676766b44156   6 hours ago   229MB
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker run -it -v /workspaces/DevOpsTraining/dockerfile:/app -d new_dockerfile
7a95fa33ee8ac6fff6becfee048d0492572c24d566210ff3691d2d2ec4c69123
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker exec -it 7a95fa33ee8ac6fff6becfee048d0492572c24d566210ff3691d2d2ec4c69123 bash
root@7a95fa33ee8a:/# ls
app  bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@7a95fa33ee8a:/# cd app
root@7a95fa33ee8a:/app# ls
1.html  Dockerfile

###########DOCKER VOLUME BETTER WAY#########
$ docker volume create test
test
docker volume ls
DRIVER    VOLUME NAME
local     test


$ docker run -it --mount source=test,target=/app -d new_dockerfile

@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker run -it --mount source=test,target=/app -d new_dockerfile
0d4ab77cc09ec56562d315728d49905e29931478cfbd8ab90826a071aa9f8695
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED         STATUS         PORTS     NAMES
0d4ab77cc09e   new_dockerfile   "/bin/sh -c 'apachec…"   9 seconds ago   Up 8 seconds             blissful_payne
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker exec -it 0d4ab77cc09e bash

@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker images
REPOSITORY       TAG       IMAGE ID       CREATED       SIZE
new_dockerfile   latest    676766b44156   7 hours ago   229MB
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker run -it --mount source=apache,target=/var/www/html -d new_dockerfile
8c28978aaf844753aef77d3fd8d34b89b7cc92b0f69398e1551eaed97fae4a9f
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ docker exec -it 8c28978aaf844753aef77d3fd8d34b89b7cc92b0f69398e1551eaed97fae4a9f bash
root@8c28978aaf84:/# ls
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@8c28978aaf84:/# cd /var/www/html
root@8c28978aaf84:/var/www/html# ls
Dockerfile  index.html
root@8c28978aaf84:/var/www/html# exit
exit
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ ls
1.html  2.html  3.html  Dockerfile
@joseivangeraldo ➜ /workspaces/DevOpsTraining/dockerfile (main) $ cd ..
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ ls
dockerfile  leiame.txt
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ touch 2.html
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ ls
2.html  dockerfile  leiame.txt
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ vi 2.html
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ docker cp ./2.html 8c28978aaf84:/var/www/html
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ docker rm -f 8c28978aaf84
8c28978aaf84
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ docker run -it source=apache,target=/var/www/html -p 81:80 -d new_dockerfile
docker: invalid reference format.
See 'docker run --help'.
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ docker images
REPOSITORY       TAG       IMAGE ID       CREATED       SIZE
new_dockerfile   latest    676766b44156   7 hours ago   229MB
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ docker run -it --mount source=apache,target=/var/www/html -p 81:80 -d new_dockerfile
86bfb0be168cc8189ebf6a86509eb6c54c8e3c23e941f12ed8b7e41c88e93057
$ docker run -it -p 84:80 -d new_dockerfile
77262fb8929964b7fd488a4f241026066f5d50ef2f4cc6c83f328fd04f7d8cee
@joseivangeraldo ➜ /workspaces/DevOpsTraining (main) $ 

################  DOCKER COMPOSE   ########################
gitpod /workspace/DevOpsTraining/compose (main) $ ls
wordpress.yaml
gitpod /workspace/DevOpsTraining/compose (main) $ mv wordpress.yaml docker-compose.yaml
gitpod /workspace/DevOpsTraining/compose (main) $ ls
docker-compose.yaml
gitpod /workspace/DevOpsTraining/compose (main) $ docker-compose up -d

Related commands
Command
Description
docker compose build
Build or rebuild services
docker compose config
Parse, resolve and render compose file in canonical format
docker compose cp
Copy files/folders between a service container and the local filesystem
docker compose create
Creates containers for a service.
docker compose down
Stop and remove containers, networks
docker compose events
Receive real time events from containers.
docker compose exec
Execute a command in a running container.
docker compose images
List images used by the created containers
docker compose kill
Force stop service containers.
docker compose logs
View output from containers
docker compose ls
List running compose projects
docker compose pause
Pause services
docker compose port
Print the public port for a port binding.
docker compose ps
List containers
docker compose pull
Pull service images
docker compose push
Push service images
docker compose restart
Restart service containers
docker compose rm
Removes stopped service containers
docker compose run
Run a one-off command on a service.
docker compose start
Start services
docker compose stop
Stop services
docker compose top
Display the running processes
docker compose unpause
Unpause services
docker compose up
Create and start containers
docker compose version
Show the Docker Compose version information



services:
  db:
    # We use a mariadb image which supports both amd64 & arm64 architecture
    image: mariadb:10.6.4-focal
    # If you really want to use MySQL, uncomment the following line
    #image: mysql:8.0.27
    command: '--default-authentication-plugin=mysql_native_password'
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=somewordpress
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - MYSQL_PASSWORD=wordpress
    expose:
      - 3306
      - 33060
  wordpress:
    image: wordpress:latest
    ports:
      - 80:80
    restart: always
    environment:
      - WORDPRESS_DB_HOST=db
      - WORDPRESS_DB_USER=wordpress
      - WORDPRESS_DB_PASSWORD=wordpress
      - WORDPRESS_DB_NAME=wordpress
volumes:
  db_data:





##########   DOCKER SWARM ##################



É preciso ter uma maquina master e uma maquina worker , duas maquinas diferentes.


###### ASSIM ESTA MAQUINA SE TORNA MANAGER QUE É O LIDER########
Swarm initialized: current node (f9lva3xmrosh5dk7zf3l1sdfu) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1ddo27a4oqdqk106oji1qh30e1vzyo9nlg851atynlldnsgasc-efjbox4lp8qieheglptncyua0 10.1.0.4:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.





