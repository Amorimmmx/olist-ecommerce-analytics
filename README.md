Projeto de Análise de Dados - Olist: Pedidos e Entregas

Dashboard de Pedidos e Entregas - Olist

Este projeto consiste em uma análise de dados da Olist, marketplace brasileiro que conecta pequenos lojistas a grandes canais de venda online. O foco é entender o volume de pedidos e o desempenho das entregas: quanto tempo os pedidos levam para chegar, quantos chegam no prazo e em que etapa do processo o tempo é gasto.

Para isso, foi construído um dashboard interativo no Power BI, com filtros por ano, mês, status do pedido e estado do cliente.

Conjuntos de dados

Os dados são do dataset público Brazilian E-Commerce Public Dataset by Olist, com pedidos feitos entre setembro de 2016 e outubro de 2018.

O esquema original do dataset tem oito tabelas, com informações sobre pedidos, clientes, itens, pagamentos, avaliações, vendedores, produtos e geolocalização. Neste projeto foram utilizadas:

olist_orders_dataset: pedidos, status e datas de cada etapa da entrega.
olist_customers_dataset: dados dos clientes, incluindo o estado, usado no filtro Estado.

As duas tabelas se relacionam pelo campo customer_id (relacionamento um para muitos).

O modelo lógico do banco de dados é apresentado no seguinte formato:

Esquema do dataset Olist

No esquema original, a tabela de clientes aparece como olist_order_customer_dataset. No arquivo do dataset, ela se chama olist_customers_dataset.

Apresentação
Dashboard Interativo

No dashboard encontram-se as principais métricas e indicadores que permitem uma compreensão do desempenho de pedidos e entregas.

Dashboard

Os visuais do painel são:

Cartões de resumo: total de pedidos, pedidos entregues, tempo médio de entrega e pedidos cancelados.
Evolução dos pedidos ao longo do tempo: volume mensal e percentual de entregas com atraso.
Onde o tempo é gasto: tempo médio por etapa (aprovação do pagamento, preparação pelo vendedor e transporte).
Pedidos não entregues, por status: distribuição dos pedidos que não chegaram ao cliente.
Entrega real x data estimada: percentual de pedidos entregues por dias de diferença em relação ao prazo.
Filtros: Ano, Mês, Status do pedido e Estado.

Confira aqui o dashboard do projeto.

Ferramentas

Para a execução dessa análise, foram utilizadas as seguintes ferramentas:

Microsoft Power BI: construção do dashboard, com o uso de funções em DAX para as medidas e visualizações.
Dataset Olist (Kaggle): fonte dos dados.
Perguntas de Negócio

1. Quantos pedidos foram feitos no período e qual o tempo médio de entrega?

Foram 99.441 pedidos entre setembro de 2016 e outubro de 2018. O tempo médio de entrega foi de 12,5 dias, considerando os pedidos entregues.

2. Qual a porcentagem de pedidos entregues no prazo?

93,2% dos pedidos entregues chegaram dentro da data estimada, e 6,8% chegaram atrasados. A maior parte das entregas (47,1%) chegou de 10 a 20 dias antes do prazo.

3. Em que mês houve o maior índice de atrasos?

O pico de atrasos foi em março de 2018, com 18,96% das entregas chegando após a data estimada.

4. Em qual etapa o tempo de entrega é mais gasto?

O transporte concentra 74% do tempo total (9,3 dias), seguido pela preparação pelo vendedor, com 22% (2,8 dias). A aprovação do pagamento representa 3% (0,4 dia).

5. Quantos pedidos não chegaram ao cliente e por quê?

Os pedidos entregues representam 97% da base. Entre os não entregues, os status mais comuns são enviado (1.107), cancelado (625) e indisponível (609). Somando cancelados e indisponíveis, são 1.234 pedidos.

6. Como o desempenho varia entre os estados?

[Escolha alguns estados no filtro Estado e descreva o que mudou: volume de pedidos, tempo médio e percentual de atraso.]

Estrutura do repositório
├── images/
│   ├── dashboard.png
│   └── esquema_olist.png
├── dash.pbix
└── README.md
Inspiração

Projeto inspirado na estrutura do repositório delivery_center_data_analysis, de Paulo Schmitz.

Autor

SEU NOME
