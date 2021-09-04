export default class Storage {
    db;

    constructor(db) {
        this.db = db;
    }

    get = async () => {
        const storage = await this.db.execute("SELECT * FROM storage");
        return storage;
    };
}
