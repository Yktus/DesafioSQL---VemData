/*Bloco D — Subqueries
1. Clientes cujo gasto total está acima da média geral de gasto por cliente.
*/


/*
2. Produtos que nunca receberam avaliação (NOT EXISTS / NOT IN).

quase sempre que alguém deseja comprar algo confere os comentarios do produto, e produtos sem comentários reduzem a chance do cliente comprar, 
saber quais produtos não tem comentarios pode ajudar a empresa em estratégias que incentivem os compradores a comentar os produtos adquiridos, um exemplo disso é
no mercado livre, ganho pontos por comentar e tirar fotos do produto, com os pontos acumulados é possível obter cupons de desconto.
*/
select * from olist_order_reviews_dataset; --order_id
select * from olist_products_dataset; 
select * from olist_order_items_dataset; 

select 
	olist_products_dataset.product_id, 
	olist_products_dataset.product_category_name
from 	
	olist_products_dataset 
where not exists (
select 
	olist_products_dataset.product_id
from 
	olist_order_items_dataset 
inner join 
	olist_order_reviews_dataset  
	on 
	olist_order_items_dataset.order_id = olist_order_reviews_dataset.order_id
where 
	olist_order_items_dataset.product_id = olist_products_dataset.product_id
);
	
/*
3. Vendedores que venderam produtos de mais de 5 categorias diferentes (subquery
com COUNT(DISTINCT ...)).
*/



/*
4. Pedidos cujo valor de frete (freight_value) é maior que o valor total dos itens do
próprio pedido (subquery correlacionada comparando as duas somas).
*/











