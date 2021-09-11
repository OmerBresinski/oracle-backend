CREATE SEQUENCE global_id START WITH 1 INCREMENT by 1;

CREATE TABLE customers (
    id  NUMBER(32)  DEFAULT global_id.nextval    NOT NULL,
    name    VARCHAR2(32)    NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY (id)
);

CREATE TABLE storage (
    id  NUMBER(32)  DEFAULT global_id.nextval    NOT NULL,
    name    VARCHAR2(32)    NOT NULL,
    CONSTRAINT storage_pk PRIMARY KEY (id)
);

CREATE TABLE item (
    id  NUMBER(32)  DEFAULT global_id.nextval  NOT NULL,
    name    VARCHAR2(32)    NOT NULL,
    item_description    VARCHAR2(256)   DEFAULT ''  NOT NULL,
    CONSTRAINT item_pk PRIMARY KEY (id)
);

CREATE TABLE orders (
    id  NUMBER(32)  DEFAULT global_id.nextval    NOT NULL,
    created_on    DATE    DEFAULT sysdate NOT NULL,
    status  VARCHAR(9)  CHECK( status IN ('open','close', 'cancelled') ),
    customer_id  NUMBER(32)   NOT NULL,

    CONSTRAINT orders_pk PRIMARY KEY (id),
    CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(id)
);

CREATE TABLE orders_row (
    id  NUMBER(32)  DEFAULT global_id.nextval    NOT NULL,
    quantity  NUMBER(32)  NOT NULL,
    item_id  NUMBER(32)  NOT NULL,
    order_id  NUMBER(32)  NOT NULL,

    CONSTRAINT orders_row_pk PRIMARY KEY (id),
    CONSTRAINT fk_orders_row_item
    FOREIGN KEY (item_id)
    REFERENCES item(id),
    CONSTRAINT fk_orders_row_order
    FOREIGN KEY (order_id)
    REFERENCES orders(id)
);

CREATE TABLE receipt (
    id  NUMBER(32)  DEFAULT global_id.nextval    NOT NULL,
    order_id  NUMBER(32)  NOT NULL,
    created_on    DATE    DEFAULT sysdate NOT NULL,
    status VARCHAR(10) DEFAULT 'charge' CHECK( status IN ('charge','refund')),
    CONSTRAINT receipt_pk PRIMARY KEY (id),
    CONSTRAINT fk_receipt_order
    FOREIGN KEY (order_id)
    REFERENCES orders(id)
);

CREATE TABLE inventory (
    id  NUMBER(32) DEFAULT global_id.nextval NOT NULL,
    storage_id NUMBER(32) NOT NULL,
    item_id NUMBER(32) NOT NULL,
    quantity NUMBER NOT NULL,
    CONSTRAINT inventory_pk PRIMARY KEY (id),
    CONSTRAINT inventory_storage_fk
      FOREIGN KEY (storage_id)
      REFERENCES storage(id),
    CONSTRAINT inventory_item_fk
      FOREIGN KEY (item_id)
      REFERENCES item(id)
);

CREATE TABLE shortage (
    id  NUMBER(32) DEFAULT global_id.nextval NOT NULL,
    item_id NUMBER(32) NOT NULL,
    quantity NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT shortage_pk PRIMARY KEY (id),
    CONSTRAINT shortage_item_fk
      FOREIGN KEY (item_id)
      REFERENCES item(id)
);

CREATE TABLE transaction (
  id  NUMBER(32) DEFAULT global_id.nextval NOT NULL,
  created_on DATE DEFAULT sysdate NOT NULL,
  item_id NUMBER(32) NOT NULL,
  quantity NUMBER NOT NULL,
  storage_id NUMBER(32) NOT NULL,
  transaction_type VARCHAR(6) CHECK( transaction_type IN ('in','out')),
  CONSTRAINT transaction_pk PRIMARY KEY (id),
    CONSTRAINT transaction_storage_fk
      FOREIGN KEY (storage_id)
      REFERENCES storage(id)
);




