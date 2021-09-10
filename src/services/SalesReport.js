export default class SalesReport {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const salesReport = await this.db.execute("SELECT * FROM item_sells_to_customer_view");
        return salesReport;
    };
}
