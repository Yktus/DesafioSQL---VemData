/*
Bloco C — Funções agregadas + GROUP BY + HAVING
1. Faturamento total por estado do cliente.

Estava usando o pgAdmin de inicio e a primeira consulta ficou estranha mostrando São Paulo com notação cientifica 5998185e+06 por ser um campo tipo REAL e limit, 
pedi ajuda da IA para ajustar round (sum (olist_order_payments_dataset.payment_value)::numeric, 2) as faturamento_total e apresentar o resultado correto ajustando o tipo, 
troquei pra DBEaver depois disso e deixei a consulta como está agora só com o sum (olist_order_payments_dataset.payment_value).

*/
select * from olist_order_payments_dataset;
select * from olist_customers_dataset;
select * from olist_orders_dataset;

select 
	olist_customers_dataset.customer_state,
	sum (olist_order_payments_dataset.payment_value) as faturamento_total
from 
	olist_orders_dataset
inner join 
	olist_order_payments_dataset
	on
	olist_orders_dataset.order_id = olist_order_payments_dataset.order_id  
inner join 
	olist_customers_dataset
	on
	olist_orders_dataset.customer_id = olist_customers_dataset.customer_id
group by
	olist_customers_dataset.customer_state
having
	sum(olist_order_payments_dataset.payment_value) >= 0
order by
    faturamento_total desc;

/*
2. Top 10 vendedores por faturamento.

entender o desempenho dos vendedores pode ajudar a empresa na criação de programas de incentivo premiando os faturamentos maiores. 
Também é importante ao definir metas como faturamento mensal/anual baseado no que cada vendedor atinge.

*/

select * from olist_sellers_dataset;
select * from olist_order_payments_dataset;
select * from olist_order_items_dataset;

select
	olist_sellers_dataset.seller_id,
	sum (olist_order_payments_dataset.payment_value) as faturamento_total
from 
	olist_order_items_dataset
inner join 
	olist_sellers_dataset
	on
	olist_order_items_dataset.seller_id = olist_sellers_dataset.seller_id
inner join 
	olist_order_payments_dataset
	on
	olist_order_payments_dataset.order_id = olist_order_items_dataset.order_id 
group by
	olist_sellers_dataset.seller_id
order by
	faturamento_total desc
limit 10;

/*
3. Ticket médio por categoria de produto.

o ticket médio pode ajudar a empresa a entender onde está seu carro forte e criar estratégias ao redor disso, promoções, 
compras casadas com produtos da mesma ou de outra categoria com ticket mais baixo, ao que parece o forte da empresa está em torno de eletrônicos. 
*/
select * from olist_products_dataset; --product_id 
select * from olist_order_items_dataset; --price

select 
	olist_products_dataset.product_category_name,
	AVG(olist_order_items_dataset.price) as ticket_medio
from 
	olist_order_items_dataset
inner join 
	olist_products_dataset
	on
	olist_products_dataset.product_id = olist_order_items_dataset.product_id
group by
	olist_products_dataset.product_category_name
order by
	ticket_medio desc;
	

/*
4. Vendedores com nota média de avaliação abaixo de 3 (HAVING AVG(...) < 3).

entender o motivo de avaliações baixa é importante quando se quer fidelizar um cliente e resolver possíveis problema com entrega, produto ruim etc. 
Inclui uma contagem de avaliações isso possibilita verificar se a avaliação baixa não está distorcida por poucas avaliações.

*/
select * from olist_order_reviews_dataset; -- order_id, review_score
select * from olist_sellers_dataset; -- seller_id
select * from olist_order_items_dataset; 

select
	olist_sellers_dataset.seller_id,
	AVG(olist_order_reviews_dataset.review_score) as avaliacao_media,
	COUNT(olist_order_reviews_dataset.review_score) AS total_avaliacoes
from olist_order_items_dataset
inner join	
	olist_sellers_dataset
	on
	olist_sellers_dataset.seller_id = olist_order_items_dataset.seller_id
inner join
	olist_order_reviews_dataset
	on 
	olist_order_items_dataset.order_id = olist_order_reviews_dataset.order_id
group by
	olist_sellers_dataset.seller_id
having 
	AVG(olist_order_reviews_dataset.review_score) < 3
order by 
	avaliacao_media desc;
	
	
/*
5. Quantidade de pedidos por forma de pagamento (GROUP BY payment_type).

inclui distinct na contagem, caso haja algum pedido utilizando mais de uma forma de pagamento.

*/
select * from olist_order_payments_dataset; -- payment type, order_id

select
	payment_type,
	COUNT (distinct olist_order_payments_dataset.order_id ) AS total_pedidos
from 	
	olist_order_payments_dataset
group by 
	olist_order_payments_dataset.payment_type
order by 
	total_pedidos desc;
	

/*
6. Peso médio dos produtos por categoria.

pode se verificar quais categorias tem um maior custo de frete por contar com produtos mais pesados, 
usei Round para o retorno não ficar muito "quebrado" limitando a duas casas depois da virgula.
*/
select * from olist_products_dataset; -- product_weight_g, product_category_name

select 	
	product_category_name,
	ROUND (AVG (olist_products_dataset.product_weight_g), 2) as peso_medio
from
	olist_products_dataset
group by
	olist_products_dataset.product_category_name
order by peso_medio desc;

/*
7. Número médio de parcelas (AVG(payment_installments)) por categoria de
produto.

como somente cartão de crédito pode ser parcelado inclui apenas transações com esse métode de pagamento no filtro, dando uma média mais correta. 
*/
select * from olist_order_payments_dataset; --order_id, payment_installments
select * from olist_products_dataset; -- product_id, product_category_name
select * from olist_order_items_dataset;


select
	olist_products_dataset.product_category_name,
	ROUND (AVG(olist_order_payments_dataset.payment_installments),2) as media_de_parcelas
from olist_order_items_dataset
inner join 
	olist_products_dataset
	on
	olist_products_dataset.product_id = olist_order_items_dataset.product_id 
inner join 
	olist_order_payments_dataset
	on
	olist_order_items_dataset.order_id = olist_order_payments_dataset.order_id 
where
	olist_order_payments_dataset.payment_type = 'credit_card' 
group by 
	olist_products_dataset.product_category_name
order by
	media_de_parcelas desc;
	









