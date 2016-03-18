# Criando uma API em Python usando o Django REST Framework


### Introdução

Nos últimos anos houve uma grande popularização do modelo de microserviços, e junto com este movimento surgiram diversas soluções para construí-los. Uma destas soluções, bem conhecida no ecossistema Python, é o Django REST Framework. Nós iremos utilizá-lo para construir um serviço simples, porém completo, responsável para criar e manter uma Lista de Tarefas (To Do List).

### Visão Geral do DRF

O [Django](http://bit.ly/257AL08) é tido como o framework mais popular para a criação de aplicações web em Python. Quem já o conhece sabe que ele faz uso da arquitetura [Model-View-Template](http://bit.ly/257BcHS) que na verdade é análoga ao velho conhecido [Model-View-Controller](http://bit.ly/257Be2m), apenas com as Views atuando como Controllers e os Templates como Views.

Dito isto, o [Django REST Framework](http://bit.ly/257BkqZ) foi construído em cima do Django e apresenta uma arquitetura que não se distancia muito deste. No caso, os Templates não existem, uma vez que os dados são apresentados no formato [JSON](http://bit.ly/257BA9j) por padrão, e as  Views também funcionam como Controllers. Os Models estão presentes como se era de esperar, representando as tabelas do banco de dados.

Além destes objetos, o DRF também possui os Serializers, que são encarregados de traduzir as representações em JSON para objetos e vice-versa.

### Organização do Projeto

[Vagrant, TDD, PostgreSQL]

### Criando o projeto

[Estrutura de um projeto Python (requirements.txt, venv)]
