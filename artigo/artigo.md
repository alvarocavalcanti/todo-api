# Criando uma API em Python usando o Django REST Framework


### Introdução

Nos últimos anos houve uma grande popularização do modelo de microserviços, e junto com este movimento surgiram diversas soluções para construí-los. Uma destas soluções, bem conhecida no ecossistema Python, é o Django REST Framework. Nós iremos utilizá-lo para construir um serviço simples, porém completo, responsável para criar e manter uma Lista de Afazeres (To Do List).

### Visão Geral do DRF

O [Django](http://bit.ly/257AL08) é tido como o framework mais popular para a criação de aplicações web em Python. Quem já o conhece sabe que ele faz uso da arquitetura [Model-View-Template](http://bit.ly/257BcHS) que na verdade é análoga ao velho conhecido [Model-View-Controller](http://bit.ly/257Be2m), apenas com as Views atuando como Controllers e os Templates como Views.

Dito isto, o [Django REST Framework](http://bit.ly/257BkqZ) foi construído em cima do Django e apresenta uma arquitetura que não se distancia muito deste. No caso, os Templates não existem, uma vez que os dados são apresentados no formato [JSON](http://bit.ly/257BA9j) por padrão, e as  Views também funcionam como Controllers. Os Models estão presentes como se era de esperar, representando as tabelas do banco de dados.

Além destes objetos, o DRF também possui os Serializers, que são encarregados de traduzir as representações em JSON para objetos e vice-versa.

### Criando o projeto

Antes de tudo nós precisamos que o Python 3.4 esteja instalado. Depois disso vamos criar uma pasta para o projeto, vamos chamá-la de `todo-project`.

Para criar um projeto Python é recomendado usar a ferramenta [virtualenv](https://virtualenv.pypa.io/en/latest/) que cria um ambiente isolado para instalar as dependências do seu projeto. Desta forma o desenvolvedor não precisa instalar estas dependências na sua máquina diretamente.

Uma vez com a ferramenta instalada, basta navegar para a pasta do projeto e criar o virtualenv da seguinte forma (vamos utilizar `env` como o nome desta pasta):

```bash
virtualenv env
```

Após este comando será criada a pasta especificada com o ambiente virtual lá dentro: `todo-project/env`. E agora é a hora de ativá-lo:

```bash
source env/bin/activate
```

> ##### Mais detalhes sobre o virtualenv
> É possível encontrar mais detalhes sobre a ferramenta no site oficial. Inclusive se o desenvolvedor estiver usando ambiente Windows os comandos acima não se aplicam, mas [nesta sessão](https://virtualenv.pypa.io/en/latest/userguide.html#activate-script) da documentação é possível encontrar os comandos equivalentes.

Com o virtualenv ativado nós podemos começar a instalar os pacotes que vamos precisar. Esta instalação é feita usando o [PIP](https://en.wikipedia.org/wiki/Pip_(package_manager) um gerenciador de pacotes para Python, e a partir da versão 3 da plataforma ele já está incluído.

É possível instalar estes pacotes um a um, porém existe uma técnica recomendada: usar um arquivo chamado `requirements.txt` para listar todas as dependências do seu projeto.

Dito isto, vamos criar este arquivo com o seguinte conteúdo:

```text
Django==1.9.2
djangorestframework==3.3.2
```

Com o arquivo criado, a estrutura do nosso projeto até o momento deve ser a seguinte:

```
todo-project/
  - env/
  - requirements.txt
```

E agora nós precisamos instalar os pacotes especificados acima, da seguinte forma:

```bash
pip install -r requirements.txt
```

Ao término da instalação nós devemos proceder para a criação, de fato, do projeto Django. Isto é feito usando o comando `django-admin`, dentro da pasta do nosso projeto e executar o seguinte comando:

```shell
django-admin startproject todo-project .
```

Ao término a nossa estrutura de projeto deverá ser a seguinte:

```
todo-project/
  - env/
  - todo-project/
    - __init__.py
    - settings.py
    - urls.py
    - wsgi.py
  - manage.py
  - requirements.txt
```

> ##### Base de dados
> Para este artigo nós vamos fazer uso das configurações padrão do projeto Django que especificam o banco SQLite, que vem incluído na distribuição do Python. Portanto, não é necessário nenhum procedimento para configurá-lo.

Neste momento nós podemos testar se o projeto Django está devidamente configurado, tentando criar as tabelas do banco de dados:

```shell
./manage.py migrate
```

E depois iniciando o servidor de aplicação:

```shell
./manage.py runserver
```

A saída do comando acima deve indicar qual o endereço no qual o nosso servidor está rodando (http://127.0.0.1:8000/ por padrão), e nós podemos acessá-lo pelo browser para ver o resultado.


### O que nós vamos construir?

Agora chega a hora de parar de falar de código para falarmos sobre negócio. Afinal, o que queremos construir? No início deste texto nós dissemos que a ideia é construir uma Lista de Afazeres, mas nós precisamos de mais detalhes do que isso. Vamos listar aqui as principais funcionalidades:

- Criar uma Lista
- Adicionar Ítens a uma Lista
- Marcar um Ítem como Concluído
- Renomear um Ítem
- Remover um Ítem de uma Lista
- Excluir uma Lista

Vale lembrar que nós vamos construir uma **API REST** e existe um conceito importante para se discutir, o de recursos (*resources*). Nós podemos pensar em um recurso como alguma coisa que queremos acessar. Este recurso deve ser identificável através da URL, por exemplo:

```
http://localhost/livros
http://localhost/livros/231
http://localhost/livros/231/capitulos/13
```

Olhando os exemplos acima nós temos *dois* recursos: Livros e Capítulos. Se prestarmos atenção também é possível identificar o padrão semântico das URLs. Quando ela termina com um recurso nós podemos esperar uma listagem, e quando existe um identificador após o recurso é esperado que nós recuperemos os detalhes de um recurso em específico.

Vale destacar o recurso Capítulos, que na aparece como um sub-recurso de Livros (que pode ser chamado de recurso de alto-nível) mas que segue o mesmo padrão semântico, sendo, assim, consistente com o conceito esperado.

### Criando nossa aplicação

Cada projeto Django é composto por uma ou mais `apps` e cada uma delas contém uma estrutura definda para agrupar `Views`, `Models` e outros objetos. Uma boa maneira de utilizar este conceito com a nossa API é pensar em cada recurso como sendo uma `app`, inclusive os sub-recursos também ficariam localizados dentro das pastas de cada recurso de alto-nível.

Com isto em mente nós podemos agora criar a nossa `app`, dando a ela o nome `listas`. Para isso, precisamos executar o seguinte comando:

```shell
cd todo-project
./manage.py startapp listas
```

Este comando vai criar uma pasta chamada listas que vai ter a seguinte estrutura:

```text
listas/
├── __init__.py
├── admin.py
├── apps.py
├── migrations
│   └── __init__.py
├── models.py
├── tests.py
└── views.py
```

Por fim, precisamos criar um super-usuário através do seguinte comando:

```shell
./manage.py createsuperuser
```

> Na hora de criar o super-usuário serão solicitadas informações para o nome, email e a senha deste usuário.

...