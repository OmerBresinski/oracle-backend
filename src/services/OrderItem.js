export default class OrderItem {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const orderItems = await this.db.execute("SELECT * FROM order_item");
        return orderItems;
    };

    create = async (orderID, items = []) => {
        for (const item of items) {
            const query = `INSERT into ORDER_ITEM (amount, item_id, order_id) VALUES (${item[1]}, ${item[0]}, ${orderID})`;
            await this.db.execute(query);
        }
    };
}
