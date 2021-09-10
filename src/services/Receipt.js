export default class Receipt {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const receipts = await this.db.execute("SELECT * FROM receipt");
        return receipts;
    };

    create = async (orderId) => {
        this.db.execute("");
    };
}
