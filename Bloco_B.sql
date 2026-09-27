/* Bloco B — JOINs
1. Relatório com categoria do produto (traduzida), valor do item, cidade do vendedor.

é possível identificar essa tabela quais estados compram mais determinada categoria de produtos e criar promoções para aproveitar essa saída
demanda maior por estado. Criar centros de distribuição com esses produtos em estoque para uma entrega mais rapida no estado em que são mais vendidos.
*/
select * from olist_order_items_dataset
select * from olist_products_dataset
select * from olist_sellers_dataset
	
select 
    olist_products_dataset.product_category_name,
    olist_order_items_dataset.price,
    olist_sellers_dataset.seller_state,
    olist_sellers_dataset.seller_id
from 
	olist_order_items_dataset 
inner join 
	olist_products_dataset  
    on 
	olist_order_items_dataset.product_id = olist_products_dataset.product_id
inner join 
	olist_sellers_dataset  
    on 
	olist_order_items_dataset.seller_id = olist_sellers_dataset.seller_id;

/*
2. Identificar pedidos com atraso na entrega, comparando data estimada com data real
de entrega (join entre orders e customers).

inclui os estados, por achar que seria útil na identificação de possíveis gargalos e melhorias nas rotas de entrega para os estados com mais atrasos, 
não faria muito sentido só as datas sem saber para onde foram enviados os pedidos.

*/
select * from olist_orders_dataset;
select * from olist_customers_dataset;

select 
olist_orders_dataset.order_id,
olist_orders_dataset.customer_id,
olist_orders_dataset.order_delivered_customer_date,
olist_orders_dataset.order_estimated_delivery_date,
olist_customers_dataset.customer_city,
olist_customers_dataset.customer_state
from 
	olist_orders_dataset
inner join 
	olist_customers_dataset
	on 
	olist_orders_dataset.customer_id = olist_customers_dataset.customer_id
where 
	olist_orders_dataset.order_delivered_customer_date > olist_orders_dataset.order_estimated_delivery_date;
 
	
/*
3. Listar pedidos e suas formas de pagamento, incluindo pedidos pagos em mais de
uma parcela (join entre orders e order_payments).

é possível veriricar as principais formas de pagamento utilizadas pelos clientes.

*/
select * from olist_orders_dataset;
select * from olist_order_payments_dataset;

select
	olist_orders_dataset.order_id,
	olist_orders_dataset.customer_id,
	olist_order_payments_dataset.payment_type,
	olist_order_payments_dataset.payment_installments,
	olist_order_payments_dataset.payment_value
from 
	olist_orders_dataset
inner join
	olist_order_payments_dataset
	on 
	olist_order_payments_dataset.order_id = olist_orders_dataset.order_id; 

/*
4. Listar produtos junto com a categoria traduzida, incluindo produtos cuja categoria
não possui tradução cadastrada (LEFT JOIN com
product_category_name_translation).

é interessante para uma empresa que venda para fora do pais que todos os produtos tenham tradução para o cliente saber o que está comprando, 
e no caso de um centro de distribuição em outro país fica facil de identificar e classificar os produtos pelos funcionarios internacionais. 

*/
select * from olist_products_dataset;
select * from product_category_name_translation;

select 
	olist_products_dataset.product_id,
	product_category_name_translation.product_category_name,
	product_category_name_translation.product_category_name_english
from 
	olist_products_dataset
left join 
	product_category_name_translation
	on 
	olist_products_dataset.product_category_name = product_category_name_translation.product_category_name
order by 
	product_category_name;

/*
5. Identificar pedidos em que o cliente e o vendedor são do mesmo estado (join entre
customers, orders, order_items e sellers).

é muito importante para o negócio saber quem é o vendedor mais próximo de certo cliente na hora de enviar um produto, 
se tenho o produto em um vendedor no mesmo estado é muito mais barato direcionar o cliente até ele, ou no caso de compras online enviar o produto a partir 
do vendedor mais própximo, mesmo estado.

*/
select * from olist_customers_dataset;
select *from olist_orders_dataset;
select * from olist_order_items_dataset;
select * from olist_sellers_dataset;

select
	olist_orders_dataset.customer.id,
	olist_customers_dataset.customer_state,
	olist_order_items_dataset.order_id,
	olist_sellers_dataset.seller_id,
	olist_sellers_dataset.seller_state
from 
	olist_order_items_dataset
inner join 


select 
    olist_orders_dataset.customer_id, 
    olist_order_items_dataset.order_id, 
    olist_sellers_dataset.seller_id, 
	olist_customers_dataset.customer_state,
    olist_sellers_dataset.seller_state
from 
    olist_orders_dataset 
inner join 
    olist_customers_dataset 
	on 
	olist_orders_dataset.customer_id = olist_customers_dataset.customer_id
inner join 
    olist_order_items_dataset 
	on 
	olist_orders_dataset.order_id = olist_order_items_dataset.order_id
inner join 
    olist_sellers_dataset 
	on
	olist_order_items_dataset.seller_id = olist_sellers_dataset.seller_id
	where 
	customer_state = seller_state;

 

	
	
