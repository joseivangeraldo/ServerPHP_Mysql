#include LAMP Server Apache: Montado em um Docker Container
[Tutorial YouTube](#)

### Recursos Necessarios

- [Docker Hub:](https://hub.docker.com/)
- [Apache Docker Imagem oficial:](https://hub.docker.com/_/httpd)
- [Mysql Docker imagem oficial:](https://hub.docker.com/_/mysql)
- [Documentação PHP:](https://www.php.net)
- [PHPMyadmin Docker imagem oficial:](https://hub.docker.com/_/phpmyadmin)

<a name="ancora"></a>

# Indice

- [Tecnologia](#tecnologia)
- [Instação do Ambiente](#instalacao)
- [Acrescentar editar arquivos](#acrescentareditar)
- [deletar docker](#deletar)

### <a id="tecnologia"> 🛠 Tecnologias</a>

As seguintes ferramentas foram usadas na construção do projeto:

- [Apache](https://httpd.apache.org/)
- [CSS](https://www.w3.org/Style/CSS/Overview.en.html/)
- [Docker](https://www.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [HTML](https://www.w3.org/html/)
- [MySql](https://www.mysql.com/)
- [Visual Studio](<https://expo.io](https://code.visualstudio.com/docs)/>)
  > [Topo](#ancora)

## <a id="instalacao">🔨 Instalação do Ambiente</a>

Instalação Imagem Docker:
Obs: Estes exemplos foram formulados totalmente em um ambiente computacional dentro da nuvem. Particulamente no codespace do Github e Gitpod. Na atualidade são as melhores plataformas para isto, balanceando os custos e beneficios. Se você não conhece ou não sabe como acessa-los, [clique aqui.](https://docs.github.com/en/codespaces/developing-in-codespaces/opening-an-existing-codespace/)

No codespace abra um terminal ou teclas use <kbd>Ctrl</kbd> + <kbd>'</kbd>
Vamos ver antes se existem imagens criadas, só para verificar

```
$ docker images
```

Se não tiver nenhuma imagem docker será mostrado uma tabela vazia:

```
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
```

Após crie a pasta de trabalho:

```
$ mkdir LampServer
```

O nome do diretório pode ser este ou qualquer outro de sua preferência.
Depois entre neste diretório:
```shell
$ cd LampServer
```
Crie um arquivo chamado docker-compose.yml. Tem de ter este nome, idêntico assim, pois se for diferente não funcionará a geração da imagem. O Codespace GitHub e Gitpod já vem com Visual Studio configurado, então para criação e edição é só digitar:

```shell
$ code docker-compose.yml
```
O docker compose, que orquestrará todas as dependencias do ambiente, e montará todas as imagens necessárias para a rodar as imagens Docker.Apache, PHP, MySql e PHPMyadmin. Sintaxe do arquivo:
```YAML
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
    - "/workspaces/ServerPHP_Mysql/LampServer/WebPage:/var/www/html"
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
```
Tomar muito cuidado com a digitação, pois ele necessita ser fortemente idêntico, então espaços, quebra de linhas, devem ser idênticos, se necessário é melhor instalar a extensão para docker compose que o Visual Studio possui. Na parte 'volumes:' foi colocado o caminho absoluto do workspace, é mais seguro e evita riscos de conflitos.
Pode ser que se depare com erros em virtude de espaços a mais ou alguma formatação incorreta.
```diff
- Importante estar dentro do diretório que foi criado, e o Docker-compose tem de estar dentro do mesmo diretório:
```
Agora vamos criar outro diretório, este que ficará todos os nossos arquivos de trabalho da WebPage:
```shell
$ mkdir webpage
```
Dentro deste diretório criar uma arquivo básico chamado index.html. Só para conferir se funcionou corretamente a geração do ambiente.
```html
<html>
	<head>
	</head>
	<body>
		Funcionou a pagina Inicial.
	</body>
</html>
```
Vamos sair deste diretório e voltar aonde esta o docker-compose.yml:
```
$ cd ..
```
Agora que estamos no diretório do arquivo docker-compose, vamos subir o ambiente:
```
$ docker-compose up -d
```
O -d significa 'detach' inicia os containers em background, e permite eles funcionarem, liberando o console para trabalhar.
Então começará a montagem das imagens,volumes e suas dependências, se não ocorrer nenhum erro, vai ligar as portas de entrada
configuradas, um alerta vai aparecer do codespace, se quiser pode fechar a janela.  </br>
![Imagem que aparece](https://github.com/joseivangeraldo/ServerPHP_Mysql/blob/main/images/Port_open_codespace.jpg)

No menu acima, da janela do terminal, temos a opção ports, aonde temos as portas que foram carregadas seguindo esta composição:
![Imagem](https://github.com/joseivangeraldo/ServerPHP_Mysql/blob/main/images/Ports_github.png)
### Configuração das portas

| Porta     | Finalidade |
| --------- | ---------- |
|  80       | http       |
|  443      | https      |
|  8001     | phpMyAdmin | 

Clicando em Open in Browser porta 80, Vai abrir a pagina inicial que foi configurada do Apache:  </br>
![ImagemApache](https://github.com/joseivangeraldo/ServerPHP_Mysql/blob/main/images/PaginaInicialApache.png)


Clicando agora na porta 8001, vai abrir a pagina inicial do phpMyAdmin.  </br>
username: lamp_demo  </br>
password: password  </br>
![imagemPHPmYaDMIN](https://github.com/joseivangeraldo/ServerPHP_Mysql/blob/main/images/PaginaInicialPHPMyAdmin.png)

<a id="acrescentareditar"></a>

## 📁 Acrescentar e Editar arquivos
Agora vamos colocar dados no nosso BD, e depois ver o retorno em uma pagina web.
Vamos entrar no MySqlAdmin, com a senha e usuario passado anteriormente, entrar no banco lamp_demo, depois enviar o arquivo blog.sql criado.  </br>
Neste arquivo temos só um teste bem simples, feito pelo texto padrão 'Lorem Ipsum', só para ver se está funcionando o BD:  </br>
```sql
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Apr 22, 2023 at 01:56 AM
-- Server version: 8.0.33
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lamp_docker`
--

-- --------------------------------------------------------

--
-- Table structure for table `blog`
--

CREATE TABLE `blog` (
  `id` int(10) UNSIGNED ZEROFILL NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `blog`
--

INSERT INTO `blog` (`id`, `title`, `content`, `date`) VALUES
(0000000001, 'Lorem Ipsum', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', '2023-04-13'),
(0000000002, 'Contrary to popular', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia,', '2023-04-12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

```
Após sair do painel MySqlAdmin, e criar dentro do diretorio webpage, a pagina web conecta.php
```php
<?php
$connect = mysqli_connect('db','lamp_demo','password','lamp_demo')
    or die ('Não foi possivel conectar');

$query = 'SELECT * FROM blog';
$result = mysqli_query($connect, $query);

echo '<h1>MySQL Content:</h1>';

while($record = mysqli_fetch_assoc($result))
{
    echo '<h2>'.$record['title'].'</h2>';
    echo '<p>'.$record['content'].'</p>';
    echo 'Posted: '.$record['date'];
    echo '<hr>';
}
?>
```
Então entramos nesta pagina via link porta 80.

🔖 Importante: 
Vai ser apresentado o erro, falando que a extensão mysqli não está presente, isto é contornado digitando dentro do diretório LampServer:
```
$ docker-compose exec www docker-php-ext-install pdo pdo_mysql mysqli
```
Aproveitamos e também instalamos além de mysqli, instalamos também a extensão pdo_mysql que pode ser necessária.  </br>
🎵 Agora tentar atualizar a pagina, se não der certo é só para o docker-compose e depois dar um start novamente:

```
$ docker-compose stop
```
```
$ docker-compose start
```

### <a id="deletar"> ⚠️ Deletar imagens e containers</a>

- se for preciso você pode deletar imagens e containers

deletar Docker container:
```
$ rm ID_container
```

Se der algum alerta tem de utilizar o force:
```
$ rm -f ID_container
```

deletar imagens:
```
$ rmi nomeimagem
```

Se der algum alerta tem de utilizar o force:
```
$ rmi -f nomeimagem
```
⚠️  Deletar de uma vez :
 
 - Parar todas as instâncias:
```
 $ docker stop $(docker ps -a -q) 
```
  
 - Remove todas as instâncias:
``` 
 $ docker rm $(docker ps -a -q)
``` 
  
 - Remove todas as imagens:
``` 
 $ docker image rm $(docker image ls -a -q)
``` 
  
 - Remove todos os volumes:
``` 
 $ docker volume prune
```
Você pode clonar este repositório:

```bash
# Clone este repositório$ g <https://github.com/joseivangeraldo/ServerPHP_Mysql>
```

MIT License

Copyright (c) <2023> <José Ivan G Silva>

