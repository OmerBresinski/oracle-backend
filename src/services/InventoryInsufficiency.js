export default class InventoryInsufficiency {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const inventoryInsufficiency = await this.db.execute("SELECT * FROM exist_shortage_view");
        return inventoryInsufficiency;
    };
}
