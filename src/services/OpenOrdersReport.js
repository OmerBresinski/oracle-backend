export default class OpenOrdersReport {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const openOrdersReport = await this.db.execute("SELECT * FROM open_orders_view ");
        return openOrdersReport;
    };
}
