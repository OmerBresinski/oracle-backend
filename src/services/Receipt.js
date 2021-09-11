import oracledb from "oracledb";

export default class Receipt {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const receipts = await this.db.execute("SELECT * FROM receipt");
        return receipts;
    };

    create = async (orderID) => {
        const createReceiptQuery = `
            DECLARE
                new_receipt_id NUMBER(10);
            BEGIN
                :new_receipt_id :=create_new_receipt(${orderID});
            END;
        `;
        const newReceiptResult = await this.db.execute(createReceiptQuery, { new_receipt_id: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER } });
        const newReceiptID = newReceiptResult.outBinds.new_receipt_id;
        return newReceiptID;
    };
}
