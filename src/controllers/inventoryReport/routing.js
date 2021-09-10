import express from "express";
import { InventoryReport } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const inventoryReport = new InventoryReport(req.db);
        const inventoryReportData = await inventoryReport.get();
        res.send(inventoryReportData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
