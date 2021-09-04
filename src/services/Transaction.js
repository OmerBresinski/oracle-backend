export default class Transaction {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const transactions = await this.db.execute("SELECT * FROM transaction");
        return transactions;
    };
}
