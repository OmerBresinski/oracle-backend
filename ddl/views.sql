create or replace view transaction_view as
    select transaction.id, transaction.created_on, transaction.quantity, transaction.item_id, transaction.storage_id, transaction.transaction_type, storage.name as storage_name, item.name
    from transaction
    left join item on item.id = transaction.item_id
    left join storage on storage.id = transaction.storage_id;


create or replace view open_orders_view as
    select orders.id as order_id, orders.created_on, customers.name as customer_name, COALESCE(count(orders_row.id), 0) as different_items, COALESCE(sum(orders_row.quantity), 0) as total_items
    from orders
    left join customers on customers.id = orders.customer_id
    left join orders_row on orders_row.order_id = orders.id
    where orders.status = 'open' group by orders.id, orders.created_on, customers.name;


/*Replace order with receipt*/
create or replace view item_sells_to_customer_view as
    select customers.id as customer_id, customers.name as customer_name, item.name as item,
    sum(orders_row.quantity) as total_sales
    from customers
    inner join orders on customers.id = orders.customer_id
    inner join orders_row on orders_row.order_id = orders.id
    inner join item on orders_row.item_id = item.id
    where orders.status = 'open' group by customers.id, customers.name, item.name;


create or replace view full_inventory_view as
    select storage.id as storage_id, storage.name as storage_name, item.id as item_id,
    item.name as item_name,inventory.quantity as quantity
    from inventory
    inner join storage on storage.id = inventory.storage_id
    inner join item on inventory.item_id = item.id;
    
    
create or replace view exist_shortage_view as 
    select case when sum(quantity) < 10 then 10 - sum(quantity) else sum(quantity) end as exist_quantity, item_id 
    from (select item_id, quantity from inventory) group by item_id;

