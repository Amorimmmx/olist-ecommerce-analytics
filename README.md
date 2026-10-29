# Projeto de Análise de Dados - Olist

![Análise de Pedidos e Entregas - Olist](images/banner.png)

Este projeto consiste em uma análise de dados de pedidos e entregas do comércio eletrônico brasileiro, a partir do dataset público da Olist. O foco é entender o volume de pedidos e o desempenho das entregas.

Para tal, foi utilizado o Power BI para a visualização geral dos números disponíveis da empresa, com um dashboard interativo que permite filtrar os dados por ano, mês, status do pedido e estado.

## A empresa

A Olist é um marketplace brasileiro que conecta pequenos lojistas a grandes canais de venda online.

O objetivo da análise é usar o dataset público da Olist para entender o volume de pedidos e o desempenho das entregas, apresentando os principais resultados em um dashboard interativo e em um resumo das perguntas de negócio.

O conjunto de dados aborda o período **entre 2016 e 2018**, com informações sobre **pedidos** e **clientes**.

## Conjuntos de dados

Os dados utilizados são do dataset público *Brazilian E-Commerce Public Dataset by Olist*, disponível no Kaggle, e cobrem pedidos feitos entre 2016 e 2018.

O esquema original do dataset é distribuído em oito tabelas, com informações sobre pedidos, clientes, itens, pagamentos, avaliações, vendedores, produtos e geolocalização. Neste projeto foram utilizadas as tabelas `olist_orders_dataset` (pedidos) e `olist_customers_dataset` (clientes), relacionadas pelo campo `customer_id`.

O modelo lógico do banco de dados é apresentado no seguinte formato:

![Esquema do dataset Olist](images/esquema_olist.png)

## Apresentação

A análise é apresentada em duas frentes:

### Dashboard Interativo:

No dashboard encontram-se as principais métricas e indicadores que permitem uma compreensão do desempenho de pedidos e entregas.

![Dashboard](images/dashboard.png)

> O gráfico de evolução dos pedidos mostra o período de janeiro de 2017 a agosto de 2018. Os demais visuais e os cartões consideram todos os pedidos, a partir de 2016.

[Confira aqui o dashboard do projeto.](COLE_AQUI_O_LINK_DO_DASHBOARD)

### Apresentação em PDF:

O arquivo [apresentacao_projeto.pdf](apresentacao_projeto.pdf) traz um resumo das principais perguntas de negócio, com as respostas e os gráficos do dashboard.

## Ferramentas

Para a execução dessa análise, foram utilizadas algumas ferramentas, tais quais:

- **MySQL**: Os indicadores foram calculados com consultas SQL no *MySQL Workbench*, criando o banco `olist_analytics` e importando os dados dos pedidos. As consultas cobrem total de pedidos por status, cancelamentos, entregas no prazo e com atraso, tempo médio de entrega e análises por mês e por ano. O script completo está em [consultas_sql](consultas_sql/consultas_sql.sql).
- **Microsoft Power BI**: O dashboard do projeto foi construído com o uso do software, com a necessidade da criação de algumas funções em DAX para a construção das visualizações.
- **Microsoft PowerPoint**: Confecção da apresentação com o resumo das perguntas de negócio.
- **Kaggle**: Fonte dos dados utilizados no projeto.

## Perguntas de Negócio

#### 1. Quantos pedidos foram feitos no período e qual o tempo médio de entrega?

Foram **99.441 pedidos** entre 2016 e 2018. O tempo médio de entrega foi de **12,5 dias**, considerando apenas os pedidos *entregues*.

#### 2. Qual a porcentagem de pedidos entregues no prazo?

Cerca de **93,2%** dos pedidos entregues chegaram dentro da data estimada, e **6,8%** chegaram com atraso. A maior parte das entregas (**47,1%**) chegou de 10 a 20 dias *antes* do prazo.

#### 3. Em que mês houve o maior índice de atrasos?

No período mostrado no gráfico de evolução (de janeiro de 2017 a agosto de 2018), o pico de atrasos foi em **março de 2018**, quando **18,96%** das entregas chegaram após a data estimada.

#### 4. Em qual etapa o tempo de entrega é mais gasto?

O *transporte* concentra **74%** do tempo total (9,3 dias), seguido pela *preparação pelo vendedor*, com 22% (2,8 dias). A *aprovação do pagamento* representa apenas 3% (0,4 dia).

#### 5. Quantos pedidos não chegaram ao cliente e em que situação estão?

Os pedidos entregues representam **97%** da base (96.478 pedidos). Os outros **2.963 pedidos** não chegaram ao cliente, e os status mais comuns entre eles são *enviado* (1.107), *cancelado* (625) e *indisponível* (609). Somando cancelados e indisponíveis, são **1.234 pedidos**. O dataset informa o status do pedido, mas não o motivo.




