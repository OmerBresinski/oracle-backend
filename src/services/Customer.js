export default class Customer {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const customers = await this.db.execute("SELECT * FROM customers");
        return customers;
    };
}
