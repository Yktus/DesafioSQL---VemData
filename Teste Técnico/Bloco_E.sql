/*Bloco E — CASE WHEN
1. Classificar pedidos por prazo de entrega: "adiantado", "no prazo" ou "atrasado"
(comparando data real x estimada).

a tabela de ordens tem outros status anteriores a previsão de entrega deixando algumas ordens sem data real e estimada, apenas a classificação no exercicio não é suficiente se for incluir
essas outras situaçoes, um pedido pode por exemplo estar atrasado sem nem ter saido para entrega ou faturado.
*/
select * from olist_orders_dataset;

select 
	order_id,
	order_status,
	order_delivered_customer_date,
	order_estimated_delivery_date,
case
	when order_delivered_customer_date > order_estimated_delivery_date then 'atrasado'
	when order_delivered_customer_date < order_estimated_delivery_date then 'adiantado'
	else 'no prazo'
end as status_entrega
from olist_orders_dataset

/*
2. Classificar clientes por faixa de gasto total: "bronze", "prata", "ouro".

inclui não informado caso apareça algum cliente sem gastos na plataforma.
*/
select * from olist_customers_dataset; --customer_unique_id
select * from olist_order_payments_dataset; --payment_value
select * from olist_orders_dataset;

SELECT
    olist_customers_dataset.customer_unique_id,
    SUM(olist_order_payments_dataset.payment_value) AS gasto_total,
    CASE
        WHEN SUM(olist_order_payments_dataset.payment_value) >= 5000 THEN 'ouro'
        WHEN SUM(olist_order_payments_dataset.payment_value) >= 2000 THEN 'prata'
        WHEN SUM(olist_order_payments_dataset.payment_value) > 0.01 THEN 'bronze'
        ELSE 'sem classificacao'
    END AS classificacao
FROM 
    olist_orders_dataset
INNER JOIN
    olist_customers_dataset
    ON olist_orders_dataset.customer_id = olist_customers_dataset.customer_id
INNER JOIN 
    olist_order_payments_dataset
    ON olist_orders_dataset.order_id = olist_order_payments_dataset.order_id
GROUP BY
    olist_customers_dataset.customer_unique_id
ORDER BY 
    gasto_total ASC;

/*
3. Classificar produtos por faixa de peso: "leve", "médio", "pesado" (com base em
product_weight_g).
*/

select 
	product_id, 
	product_category_name,
	product_weight_g, 
case
	when olist_products_dataset.product_weight_g < 5000 then 'leve'
	when olist_products_dataset.product_weight_g < 15000 then 'medio'
	when olist_products_dataset.product_weight_g >= 15000 then 'pesado'
else 'nao informado'
end as 
	classificacao_de_peso
from 
	olist_products_dataset;

/*
4. Classificar pagamentos como "à vista" ou "parcelado", e dentro de parcelado
sinalizar parcelamentos longos (payment_installments > 6).
*/
select * from olist_order_payments_dataset;

select 	
	order_id,
	payment_type,
	payment_sequential,
	payment_installments,
	payment_value,
case 
	when payment_installments = 1 then 'a vista'	
	when payment_installments <= 5 then 'parcelado'
	when payment_installments >= 6 then 'parcelado longo'
	else 'não identificado'
end as classificacao_de_pagamento
from
olist_order_payments_dataset;














