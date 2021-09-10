/*Change if/else statement to CASE or DECODE*/
/*Try using this in line instead of as a function - probably in the Add Item Insufficiency trigger*/
/**/
create or replace function get_shortage(i_amount IN NUMBER)
    return number
    IS
        shortage NUMBER;
    begin
        if i_amount < 10 THEN
            shortage := 10 - i_amount;
        else
            shortage := 0;
        end if;
    return(shortage);
    end get_shortage;

/*Use this to create an order with an order id, then use that orderid to create order_row for each item*/
create or replace function create_new_order(p_customer_id IN orders.customer_id%type)
return orders.id%type
IS
order_id orders.id%type;
begin
       INSERT INTO orders (customer_id, order_status)
        VALUES (p_customer_id, 'open')
        returning id into order_id;
    return(order_id);
end create_new_order;


/*Use this function in line in the create_new_receipt function*/
create or replace function is_valid_to_create_new_receipt(i_order_id IN NUMBER)
return number
IS
    is_valid NUMBER;
    missing_count NUMBER;
begin
        select count(1) into missing_count
        from inventory inv
        join order_item oi on oi.item_id = inv.item_id
        where inv.quantity<oi.amount and oi.order_id = i_order_id;
  if missing_count > 0 then
    is_valid := 0;
  else is_valid := 1;
 end if;
  return(is_valid);
end is_valid_to_create_new_receipt;

/*Convert this function to a procedure*/
create or replace function create_new_receipt(i_order_id IN receipt.order_id%type)
return receipt.id%type
IS
receipt_id receipt.id%type;
is_valid number;
cursor ix is
                select order_item.amount, order_item.item_id, inventory.id as inv_id, (inventory.quantity-order_item.amount) as new_quantity, inventory.warehouse_id as warehouse_id
                        from order_item left join inventory on order_item.item_id = inventory.item_id
                where order_item.order_id = i_order_id;
begin

        is_valid := is_valid_to_create_new_receipt(i_order_id);
        if is_valid = 0 then
        /*Change this error to a different type*/
            raise_application_error(-1, 'Items are missing, cannot create new receipt');
        end if;
       INSERT INTO receipt (order_id)
        VALUES (i_order_id)
        returning id into receipt_id;
        for x in ix loop
            insert into transaction (item_id, quantity, warehouse_id, transaction_type) values (x.item_id, x.amount, x.warehouse_id, 'charge');
            update INVENTORY SET QUANTITY= x.new_quantity where id = x.inv_id;
        end loop;
        UPDATE orders 
        SET order_status = 'close'
        WHERE orders.id = i_order_id;
    return(receipt_id);
end create_new_receipt;


create or replace function cancel_receipt(p_receipt_id IN receipt.id%type)
return receipt.id%type
IS
existing_receipt_status receipt.status%type;
cursor ix is
                select order_item.amount, order_item.item_id, inventory.id as inv_id, (inventory.quantity+order_item.amount) as new_quantity, inventory.warehouse_id as warehouse_id
                        from order_item 
                        inner join receipt on receipt.order_id = order_item.order_id
                        inner join inventory on order_item.item_id = inventory.item_id

                where receipt.id = p_receipt_id;
begin
        select status into existing_receipt_status from receipt where id = p_receipt_id;
        if existing_receipt_status = 'refund' then
            raise_application_error(-1, 'This receipt has already been canceled');
        end if;
       UPDATE receipt  set status = 'refund' where id = p_receipt_id;
        for x in ix loop
            insert into transaction (item_id, quantity, warehouse_id, transaction_type) values (x.item_id, x.amount, x.warehouse_id, 'refund');
            update INVENTORY SET QUANTITY= x.new_quantity where id = x.inv_id;
        end loop;
    return(p_receipt_id);
end cancel_receipt;