export default class TransactionsReport {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const transactionsReport = await this.db.execute("SELECT * FROM transaction_view");
        return transactionsReport;
    };
}
