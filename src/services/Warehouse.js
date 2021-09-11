export default class Warehouse {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const warehouse = await this.db.execute("SELECT * FROM storage");
        return warehouse;
    };
}
