
-- ============================================================
-- PROJETO: OLIST ANALYTICS
-- Objetivo: analisar pedidos, cancelamentos e entregas
-- usando SQL e o banco de dados MySQL.
--
-- Neste projeto, estou praticando consultas SQL com dados
-- reais de e-commerce para encontrar indicadores e padrões
-- que possam ajudar a entender o desempenho das entregas.
-- ============================================================


-- ============================================================
-- 1. CRIANDO O BANCO DE DADOS
-- ============================================================

-- Crio o banco de dados onde vou trabalhar com os dados da Olist.
CREATE DATABASE olist_analytics;

-- Seleciono o banco de dados para executar os próximos comandos nele.
USE olist_analytics;


-- ============================================================
-- 2. CRIANDO A TABELA DE PEDIDOS
-- ============================================================

-- Crio a tabela orders para armazenar os dados dos pedidos.
-- Cada coluna guarda uma informação diferente, como o código
-- do pedido, o status e as datas de compra e entrega.

CREATE TABLE orders (
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

-- order_id e customer_id armazenam identificadores em texto.
-- order_status guarda a situação atual do pedido.
-- As colunas DATETIME armazenam datas e horários.
--
-- Depois de criar a tabela, importei os dados do arquivo
-- olist_orders_dataset.csv usando o assistente de importação
-- do MySQL Workbench.


-- ============================================================
-- 3. CONHECENDO OS DADOS
-- ============================================================

-- Visualizo todos os registros e todas as colunas da tabela.
-- É útil para conferir os dados, mas pode retornar muitas linhas.
SELECT * FROM orders;


-- Conto quantos registros existem na tabela.
-- Usei essa consulta para conferir se os dados foram importados.
SELECT COUNT(*) FROM orders;


-- Visualizo somente os primeiros 10 registros.
-- LIMIT 10 evita que eu precise mostrar a tabela inteira.
SELECT * FROM orders LIMIT 10;


-- Identifico quais status diferentes existem na base.
-- DISTINCT evita que o mesmo status apareça várias vezes.
SELECT DISTINCT order_status
FROM orders;


-- Conto quantos pedidos existem em cada status.
-- GROUP BY reúne os pedidos com o mesmo status.
-- ORDER BY COUNT(*) DESC mostra primeiro os maiores totais.
SELECT
    order_status,
    COUNT(*)
FROM orders
GROUP BY order_status
ORDER BY COUNT(*) DESC;


-- Conto somente os pedidos cancelados.
-- WHERE filtra os registros antes do agrupamento.
SELECT
    order_status,
    COUNT(*)
FROM orders
WHERE order_status = 'canceled'
GROUP BY order_status;


-- ============================================================
-- 4. TOTAL DE PEDIDOS E CANCELAMENTOS
-- ============================================================

-- Conto todos os pedidos e dou um nome mais claro ao resultado.
-- AS cria um apelido para a coluna exibida na consulta.
SELECT
    (SELECT COUNT(*) FROM orders) AS total_pedidos;


-- Conto somente os pedidos cancelados.
SELECT
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'canceled') AS pedidos_cancelados;


-- Calculo a porcentagem de pedidos cancelados em relação
-- ao total de pedidos.
--
-- A primeira subconsulta conta os pedidos cancelados.
-- A segunda conta todos os pedidos.
-- Divido os cancelados pelo total e multiplico por 100.
SELECT
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'canceled')
    /
    (SELECT COUNT(*)
     FROM orders)
    * 100 AS percentual_cancelados;


-- ============================================================
-- 5. ANALISANDO AS ENTREGAS
-- ============================================================

-- Conto quantos pedidos possuem o status delivered.
SELECT COUNT(*) AS pedidos_entregues
FROM orders
WHERE order_status = 'delivered';


-- Conto os pedidos cujo status é diferente de delivered.
-- O operador <> significa "diferente de".
--
-- Atenção: isso inclui todos os outros status, como shipped,
-- canceled e processing. Não significa que todos esses pedidos
-- nunca serão entregues.
SELECT COUNT(*) AS pedidos_nao_entregues
FROM orders
WHERE order_status <> 'delivered';


-- Verifico quantos pedidos entregues possuem uma data
-- de entrega registrada.
--
-- IS NOT NULL seleciona registros em que a data não está vazia.
SELECT COUNT(*) AS pedidos_entregues_com_data
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;


-- Conto os pedidos entregues depois da data estimada.
-- O operador > significa "maior que".
-- Como estamos comparando datas, identifica entregas posteriores
-- ao prazo estimado.
SELECT COUNT(*) AS pedidos_entregues_com_atraso
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date;


-- Calculo a porcentagem de pedidos entregues com atraso.
-- Divido a quantidade de entregas atrasadas pelo total de
-- pedidos entregues e multiplico por 100.
SELECT
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'delivered'
       AND order_delivered_customer_date > order_estimated_delivery_date)
    /
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'delivered')
    * 100 AS percentual_atrasados;


-- Conto os pedidos entregues na data estimada ou antes dela.
-- <= significa "menor ou igual a".
SELECT COUNT(*) AS pedidos_no_prazo
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date <= order_estimated_delivery_date;


-- Calculo a porcentagem de pedidos entregues no prazo ou antes.
SELECT
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'delivered'
       AND order_delivered_customer_date <= order_estimated_delivery_date)
    /
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'delivered')
    * 100 AS percentual_no_prazo;


-- Organizo a quantidade de pedidos por status.
-- Essa consulta também serve para visualizar a distribuição
-- geral dos pedidos, do status mais frequente ao menos frequente.
SELECT
    order_status,
    COUNT(*) AS total_pedidos
FROM orders
GROUP BY order_status
ORDER BY total_pedidos DESC;


-- ============================================================
-- 6. ANALISANDO OS PEDIDOS POR MÊS E POR ANO
-- ============================================================

-- Conto quantos pedidos foram registrados em cada mês.
--
-- YEAR() extrai o ano da data.
-- MONTH() extrai o mês.
-- GROUP BY reúne os pedidos do mesmo ano e mês.
-- ORDER BY ano, mes organiza os resultados cronologicamente.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    MONTH(order_purchase_timestamp) AS mes,
    COUNT(*) AS total_pedidos
FROM orders
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    ano,
    mes;


-- Identifico os dois meses com maior quantidade de pedidos.
-- DESC coloca os maiores totais primeiro.
-- LIMIT 2 retorna somente os dois primeiros resultados.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    MONTH(order_purchase_timestamp) AS mes,
    COUNT(*) AS total_pedidos
FROM orders
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY total_pedidos DESC
LIMIT 2;


-- Comparo a quantidade total de pedidos por ano.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    COUNT(*) AS total_pedidos
FROM orders
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY total_pedidos DESC;


-- ============================================================
-- 7. ANALISANDO OS CANCELAMENTOS POR ANO
-- ============================================================

-- Conto quantos pedidos foram cancelados em cada ano.
-- O filtro WHERE considera somente os pedidos cancelados.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    COUNT(*) AS pedidos_cancelados
FROM orders
WHERE order_status = 'canceled'
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY ano;


-- Comparo o total de pedidos com a quantidade de cancelamentos
-- e calculo a taxa de cancelamento por ano.
--
-- SUM(order_status = 'canceled') soma 1 para cada registro
-- que atende à condição e 0 para os demais, no MySQL.
--
-- ROUND(..., 2) arredonda a porcentagem para duas casas decimais.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    COUNT(*) AS total_pedidos,
    SUM(order_status = 'canceled') AS pedidos_cancelados,
    ROUND(
        SUM(order_status = 'canceled') / COUNT(*) * 100,
        2
    ) AS percentual_cancelados
FROM orders
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY ano;


-- ============================================================
-- 8. CALCULANDO O TEMPO MÉDIO DE ENTREGA
-- ============================================================

-- Calculo quantos dias se passaram, em média, entre a compra
-- e a entrega ao cliente.
--
-- DATEDIFF() calcula a diferença em dias entre duas datas.
-- AVG() calcula a média das diferenças.
-- ROUND(..., 2) mantém duas casas decimais.
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS media_dias_entrega
FROM orders
WHERE order_status = 'delivered';


-- Calculo a diferença média entre a data real de entrega
-- e a data estimada para a entrega.
--
-- Resultado negativo: a entrega ocorreu antes do prazo,
-- em média.
-- Resultado positivo: a entrega ocorreu depois do prazo,
-- em média.
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_estimated_delivery_date
            )
        ),
        2
    ) AS media_diferenca_dias
FROM orders
WHERE order_status = 'delivered';


-- Analiso o tempo médio entre compra e entrega em cada mês.
-- Assim consigo comparar os períodos ao longo dos anos.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    MONTH(order_purchase_timestamp) AS mes,
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS media_dias_entrega
FROM orders
WHERE order_status = 'delivered'
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    ano,
    mes;


-- Identifico o mês com a maior média de dias entre compra
-- e entrega.
--
-- A ordenação DESC coloca a maior média primeiro.
-- LIMIT 1 mostra somente o mês com o maior resultado.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    MONTH(order_purchase_timestamp) AS mes,
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS media_dias_entrega
FROM orders
WHERE order_status = 'delivered'
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    media_dias_entrega DESC
LIMIT 1;


-- ============================================================
-- 9. MESES COM MAIS CANCELAMENTOS
-- ============================================================

-- Identifico os cinco meses com mais pedidos cancelados.
-- Agrupo por ano e mês para não misturar, por exemplo,
-- janeiro de anos diferentes.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    MONTH(order_purchase_timestamp) AS mes,
    COUNT(*) AS pedidos_cancelados
FROM orders
WHERE order_status = 'canceled'
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    pedidos_cancelados DESC
LIMIT 5;


-- ============================================================
-- 10. DISTRIBUIÇÃO DOS PEDIDOS EM PORCENTAGEM
-- ============================================================

-- Mostro o total de pedidos por status e qual porcentagem
-- cada status representa em relação ao total da base.
--
-- A subconsulta calcula o total geral de pedidos.
-- COUNT(*) conta os pedidos de cada status.
-- ROUND(..., 2) arredonda o percentual para duas casas decimais.
SELECT
    order_status,
    COUNT(*) AS total_pedidos,
    ROUND(
        COUNT(*) / (SELECT COUNT(*) FROM orders) * 100,
        2
    ) AS percentual
FROM orders
GROUP BY order_status
ORDER BY total_pedidos DESC;


-- ============================================================
-- 11. TAXA DE ENTREGAS NO PRAZO POR ANO
-- ============================================================

-- Comparo o desempenho das entregas em cada ano.
--
-- COUNT(*) conta os pedidos entregues naquele ano.
-- SUM(data_real <= data_estimada) conta os pedidos entregues
-- na data estimada ou antes dela.
-- A divisão pelo total de pedidos entregues, multiplicada
-- por 100, gera a porcentagem de entregas no prazo.
--
-- Esse indicador ajuda a comparar o desempenho entre os anos.
SELECT
    YEAR(order_purchase_timestamp) AS ano,
    COUNT(*) AS pedidos_entregues,
    SUM(
        order_delivered_customer_date <= order_estimated_delivery_date
    ) AS entregues_no_prazo,
    ROUND(
        SUM(
            order_delivered_customer_date <= order_estimated_delivery_date
        ) / COUNT(*) * 100,
        2
    ) AS percentual_no_prazo
FROM orders
WHERE order_status = 'delivered'
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY ano;


-- ============================================================
-- FIM DA ANÁLISE PRINCIPAL
-- ============================================================