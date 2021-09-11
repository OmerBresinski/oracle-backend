
/**/
create or replace function get_shortage(amount in number)
    return number
    is
        shortage number;
    begin
        case 
            when amount < 10 then shortage := 10 - amount;
            else shortage := 0;
        end case;
        return(shortage);
end get_shortage;

/*Use this to create an order with an order id, then use that orderid to create order_row for each item (in the ui)*/
/**/
create or replace function create_new_order(p_customer_id in orders.customer_id%type)
return orders.id%type
is
order_id orders.id%type;
begin
       insert into orders (customer_id, status)
        values (p_customer_id, 'open')
        returning id into order_id;
    return(order_id);
end create_new_order;


/*Convert this function to a procedure (if possible)*/
create or replace function is_valid_to_create_new_receipt(i_order_id in number)
return number
is
    is_valid number;
    missing_count number;
begin
        select count(1) into missing_count
        from inventory inv
        join orders_row oi on oi.item_id = inv.item_id
        where inv.quantity < oi.quantity and oi.order_id = i_order_id;
  if missing_count > 0 then
    is_valid := 0;
  else is_valid := 1;
 end if;
  return(is_valid);
end is_valid_to_create_new_receipt;

create or replace function create_new_receipt(i_order_id in receipt.order_id%type)
return receipt.id%type
is
receipt_id receipt.id%type;
is_valid number;

begin
    is_valid := is_valid_to_create_new_receipt(i_order_id);
    if is_valid = 0 then
    /*Change this error to a different type*/
        raise_application_error(-20001, 'Items are missing, cannot create new receipt');
    end if;
   insert into receipt (order_id)
    values (i_order_id)
    returning id into receipt_id;

    update orders 
    set status = 'close'
    where orders.id = i_order_id;
    return (receipt_id);
end create_new_receipt;


create or replace function cancel_receipt(p_receipt_id in receipt.id%type)
return receipt.id%type
is
existing_receipt_status receipt.status%type;
cursor ix is
        select orders_row.quantity, orders_row.item_id, inventory.id as inv_id, (inventory.quantity + orders_row.quantity) as new_quantity, inventory.storage_id as storage_id
                from orders_row 
                inner join receipt on receipt.order_id = orders_row.order_id
                inner join inventory on orders_row.item_id = inventory.item_id

        where receipt.id = p_receipt_id;
begin
        select status into existing_receipt_status from receipt where id = p_receipt_id;
        if existing_receipt_status = 'refund' then
            raise_application_error(-20002, 'This receipt has already been cancelled');
        end if;
        update receipt set status = 'refund' where id = p_receipt_id;
        for x in ix loop
            insert into transaction (item_id, quantity, storage_id, transaction_type) values (x.item_id, x.quantity, x.storage_id, 'out');
            update inventory set quantity = x.new_quantity where id = x.inv_id;
        end loop;
    return(p_receipt_id);
end cancel_receipt;









