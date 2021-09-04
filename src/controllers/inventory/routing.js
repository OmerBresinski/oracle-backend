import express from "express";
import { Inventory } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const inventory = new Inventory(req.db);
        const inventoryItems = await inventory.get();
        res.send(inventoryItems);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
