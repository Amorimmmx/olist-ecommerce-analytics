# Projeto de Análise de Dados - Olist

![Análise de Pedidos e Entregas - Olist](images/banner.png)

Este projeto consiste em uma análise de dados da Olist, um marketplace brasileiro que conecta pequenos lojistas a grandes canais de venda online. O foco é entender o volume de pedidos e o desempenho das entregas no comércio eletrônico brasileiro.

Para tal, foi utilizado o Power BI para a visualização geral dos números disponíveis da empresa, com um dashboard interativo que permite filtrar os dados por ano, mês, status do pedido e estado.

## Conjuntos de dados

Os dados utilizados são do dataset público *Brazilian E-Commerce Public Dataset by Olist*, disponível no Kaggle, e cobrem pedidos feitos entre setembro de 2016 e outubro de 2018.

O esquema original do dataset é distribuído em oito tabelas, com informações sobre pedidos, clientes, itens, pagamentos, avaliações, vendedores, produtos e geolocalização. Neste projeto foram utilizadas as tabelas `olist_orders_dataset` (pedidos) e `olist_customers_dataset` (clientes), relacionadas pelo campo `customer_id`.

O modelo lógico do banco de dados é apresentado no seguinte formato:

![Esquema do dataset Olist](images/esquema_olist.png)

## Apresentação

A análise é apresentada por meio de um dashboard interativo:

### Dashboard Interativo:

No dashboard encontram-se as principais métricas e indicadores que permitem uma compreensão do desempenho de pedidos e entregas.

![Dashboard](images/dashboard.png)

[Confira aqui o dashboard do projeto.](COLE_AQUI_O_LINK_DO_DASHBOARD)

## Ferramentas

Para a execução dessa análise, foram utilizadas algumas ferramentas, tais quais:

- **Microsoft Power BI**: O dashboard do projeto foi construído com o uso do software, com a necessidade da criação de algumas funções em DAX para a construção das visualizações.
- **Kaggle**: Fonte dos dados utilizados no projeto.

## Perguntas de Negócio

#### 1. Quantos pedidos foram feitos no período e qual o tempo médio de entrega?

Foram 99.441 pedidos entre setembro de 2016 e outubro de 2018. O tempo médio de entrega foi de 12,5 dias, considerando apenas os pedidos *entregues*.

#### 2. Qual a porcentagem de pedidos entregues no prazo?

Cerca de 93,2% dos pedidos entregues chegaram dentro da data estimada, e 6,8% chegaram com atraso. A maior parte das entregas (47,1%) chegou de 10 a 20 dias *antes* do prazo.

#### 3. Em que mês houve o maior índice de atrasos?

O pico de atrasos foi em março de 2018, quando 18,96% das entregas chegaram após a data estimada.

#### 4. Em qual etapa o tempo de entrega é mais gasto?

O *transporte* concentra 74% do tempo total (9,3 dias), seguido pela *preparação pelo vendedor*, com 22% (2,8 dias). A *aprovação do pagamento* representa apenas 3% (0,4 dia).

#### 5. Quantos pedidos não chegaram ao cliente e por quê?

Os pedidos entregues representam 97% da base. Entre os não entregues, os status mais comuns são *enviado* (1.107), *cancelado* (625) e *indisponível* (609). Somando cancelados e indisponíveis, são 1.234 pedidos.

#### 6. Como o desempenho varia entre os estados?

[Escolha alguns estados no filtro Estado e descreva o que mudou: volume de pedidos, tempo médio e percentual de atraso.]
