CREATE OR REPLACE VIEW transaction_view AS
    SELECT transaction.id, transaction.created_at, transaction.quantity, transaction.item_id, transaction.warehouse_id, transaction.transaction_type
    warehouse.warehouse_name as warehouse_name, item.item_name
    FROM transaction
    LEFT JOIN item on item.id = transaction.item_id
    LEFT JOIN warehouse on warehouse.id = transaction.warehouse_id;


CREATE OR REPLACE VIEW open_orders_view AS
    SELECT orders.id as order_id, orders.created_at, customers.customer_name as customer_name, COALESCE(count(order_item.id), 0) as different_items, COALESCE(sum(order_item.amount), 0) as total_items
    FROM orders
    LEFT JOIN customers on customers.id = orders.customer_id
    LEFT JOIN order_item on order_item.order_id = orders.id
    Where orders.order_status = 'open' group by orders.id, orders.created_at, customers.customer_name;


/*Replace order with receipt*/
CREATE OR REPLACE VIEW item_sells_to_customer_view AS
    SELECT customers.id as customer_id, customers.customer_name as customer_name, item.item_name as item,
    sum(order_item.amount) as total_sales
    FROM customers
    INNER JOIN orders on customers.id = orders.customer_id
    INNER JOIN order_item on order_item.order_id = orders.id
    INNER JOIN item on order_item.item_id = item.id
    Where orders.order_status = 'open' group by customers.id, customers.customer_name, item.item_name;


CREATE OR REPLACE VIEW full_inventory_view AS
    SELECT warehouse.id as warehouse_id, warehouse.warehouse_name as warehouse_name, item.id as item_id,
    item.item_name as item_name,inventory.quantity as quantity
    FROM inventory
    INNER JOIN warehouse on warehouse.id = inventory.warehouse_id
    INNER JOIN item on inventory.item_id = item.id;