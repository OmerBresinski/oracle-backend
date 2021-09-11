create or replace trigger on_create_receipt
after insert on receipt
for each row
declare
cursor ix is
        select orders_row.quantity as quantity, inventory.id as inventory_id, orders_row.item_id, (inventory.quantity - orders_row.quantity) as new_quantity, inventory.storage_id as storage_id
        from orders_row left join inventory on orders_row.item_id = inventory.item_id
        where orders_row.order_id = :new.order_id;
begin
    for x in ix loop
      insert into transaction (item_id, storage_id, quantity, transaction_type) values (x.item_id, x.storage_id, x.quantity, 'in');
      update inventory set quantity= x.new_quantity where id = x.inventory_id;
    end loop;
end;

/**/


