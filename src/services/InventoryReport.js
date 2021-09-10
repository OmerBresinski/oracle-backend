export default class InventoryReport {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const inventoryReport = await this.db.execute("SELECT * FROM full_inventory_view");
        return inventoryReport;
    };
}
