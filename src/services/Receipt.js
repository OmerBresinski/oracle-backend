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

    cancel = async (receiptID) => {
        const cancelReceiptQuery = `
            DECLARE
                cancel_receipt_id NUMBER(10);
            BEGIN
                :cancel_receipt_id :=cancel_receipt(${receiptID});
            END;
        `;
        const cancelReceiptResult = await this.db.execute(cancelReceiptQuery, {
            cancel_receipt_id: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
        });
        const cancelledReceiptID = cancelReceiptResult.outBinds.cancel_receipt_id;
        return cancelledReceiptID;
    };
}
