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


