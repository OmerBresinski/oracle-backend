export default class InventoryInsufficiency {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const inventoryInsufficiency = await this.db.execute("SELECT * FROM inventory_insufficiency");
        return inventoryInsufficiency;
    };
}
