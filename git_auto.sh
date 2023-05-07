#!/bin/bash

########################################################################################

# Arquivo para automatizar : git commit, git add, git push                             #

#									                                                   #	

# Nome: git_auto.sh							                                           #

#									                                                   #

# Autor: José Ivan G da Silva (ivan.geraldo@gmail.com)	                               #

# Data: 05/07/2023							                                           #

#									                                                   #

# Descrição: Ao terminar a fase do projeto executar na pasta raiz do diretorio,        #

# Será excuta a adição o comitt com o comentario da data da alteração,horas e minutos  #

#				                                                     				   #

# Uso: ./git_auto.sh 						                                           #

#									                                                   #

########################################################################################

NOW=$(date +'%Y-%m-%d %H:%M:%S')

#add arquivo

git add .

sleep 3

# add comentarios

git commit -m "$NOW"

sleep 3

git push
