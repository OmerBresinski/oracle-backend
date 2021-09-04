import express from "express";
import { Warehouse } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const warehouse = new Warehouse(req.db);
        const warehouseData = await warehouse.get();
        res.send(warehouseData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
