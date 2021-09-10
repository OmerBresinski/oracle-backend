CREATE or replace PROCEDURE ADD_INVENTORY_INSUFFICIENCY(i_item_id IN NUMBER, shortage IN NUMBER)
IS
BEGIN
  INSERT INTO inventory_insufficiency (item_id, quantity)
    VALUES (i_item_id, shortage);
END ADD_INVENTORY_INSUFFICIENCY;