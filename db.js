import oracledb from "oracledb";

const ORACLE_DB_CONFIG = {
    user: "SYSTEM",
    password: "admin",
    connectString: "localhost/XEPDB1",
};

export const dbConnection = async (req, res, next) => {
    try {
        req.db = await oracledb.getConnection(ORACLE_DB_CONFIG);
    } catch (ex) {
        res.status(400).json(ex.message);
    } finally {
        next();
    }
};
