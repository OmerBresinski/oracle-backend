export default class Item {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const items = await this.db.execute("SELECT * FROM items");
        return items;
    };
}
