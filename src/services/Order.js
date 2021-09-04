export default class Order {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const orders = await this.db.execute("SELECT * FROM orders");
        return orders;
    };
}
