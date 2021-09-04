export default class ReceiptItem {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const receiptItems = await this.db.execute("SELECT * FROM receipt_item");
        return receiptItems;
    };
}
