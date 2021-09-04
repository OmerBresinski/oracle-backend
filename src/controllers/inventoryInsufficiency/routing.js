import express from "express";
import { InventoryInsufficiency } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const inventoryInsufficiency = new InventoryInsufficiency(req.db);
        const inventoryInsufficiencyData = await inventoryInsufficiency.get();
        res.send(inventoryInsufficiencyData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
