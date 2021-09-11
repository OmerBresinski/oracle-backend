import oracledb from "oracledb";
import OrderItem from "../services/OrderItem.js";

export default class Order {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const orders = await this.db.execute("SELECT * FROM orders");
        return orders;
    };

    create = async (customerID, itemIDs = []) => {
        const orderItem = new OrderItem(this.db);
        const createOrderQuery = `
            DECLARE
                new_order_id NUMBER(32);
            BEGIN
                :new_order_id :=create_new_order(${customerID});
            END;
        `;
        const newOrderResult = await this.db.execute(createOrderQuery, { new_order_id: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER } });
        const newOrderID = newOrderResult.outBinds.new_order_id;
        await orderItem.create(newOrderID, itemIDs);
        return newOrderID;
    };

    cancel = async (orderID) => {
        const execution = await this.db.execute(`UPDATE orders SET STATUS = 'cancelled' where ID = ${orderID}`);
        return !!execution.rowsAffected;
    };
}
