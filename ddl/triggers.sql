create or replace TRIGGER update_or_insert_inventory_create_or_update_inventory_insufficiency
before Update OR INSERT ON inventory
FOR EACH ROW
DECLARE
shortage integer := 0;
BEGIN
    if :NEW.quantity < 10 THEN
        shortage := 10 - :NEW.quantity;
    else
        shortage := 0;
    end if;
    UPDATE inventory_insufficiency 
    SET inventory_insufficiency.quantity = shortage
    WHERE inventory_insufficiency.item_id = :NEW.item_id;
END;

/**/

create or replace TRIGGER on_new_item_add_shortage
before INSERT ON item
FOR EACH ROW
BEGIN    
INSERT INTO shortage (item_id) values (:NEW.id);
END;
