
-- Bloco A — SELECT básico

/*
1. Listar os 20 pedidos com status delivered mais recentes, ordenados pela data de
entrega. 

é possível identificar o quão eficiente é a entrega da empresa, comparando a data de entrega ao cliente com a saída do produto 
e identificar possíveis gargalos no processo e melhorias para encurtar o tempo de entrega dos produtos.
*/

select * from olist_orders_dataset 
where order_status = 'delivered'
order by order_delivered_customer_date DESC 
limit 20;

/*
2. Listar todos os produtos de uma categoria específica (usando a tabela de tradução
para filtrar pelo nome em português).

nessa tabela poderia consultar se o produto tem fotos, que é importante para um site web ter fotos em todos os produtos 
para que os consumidores possam identificar o que estão comprando, essa tabela também trás as dimensões e peso dos produtos, uma informação
importante na hora de calcular custos de frete e na hora de decidir se o produto precisa de um caminhão ou um motoboy para ser entregue.

*/

select * from olist_products_dataset
where product_category_name = 'instrumentos_musicais';

/*
3. Listar os métodos de pagamento distintos utilizados na base (SELECT DISTINCT
payment_type).

não tinha visto o comando DISTINCT ainda, achei interessante, possibilita verificar os tipos de pagamento disponibilidados ao cliente.
*/

select distinct payment_type from olist_order_payments_dataset;

/*
4. Listar os produtos com peso (product_weight_g) acima de 10kg, ordenados do
mais pesado para o mais leve.

através dessa pesquisa é possível entender quais os produtos mais pesados que que geram maior custo de transporte.
*/

select * from olist_products_dataset
where product_weight_g > 10000
order by product_weight_g DESC;

