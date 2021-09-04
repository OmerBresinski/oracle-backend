export default class OrderItem {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const orderItems = await this.db.execute("SELECT * FROM order_item");
        return orderItems;
    };
}
