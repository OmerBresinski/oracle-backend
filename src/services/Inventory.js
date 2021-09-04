export default class Inventory {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const inventory = await this.db.execute("SELECT * FROM inventory");
        return inventory;
    };
}
