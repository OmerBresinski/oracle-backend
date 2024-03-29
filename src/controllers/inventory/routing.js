import express from "express";
import { Inventory } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const inventory = new Inventory(req.db);
        const inventoryData = await inventory.get();
        res.send(inventoryData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
