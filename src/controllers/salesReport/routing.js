import express from "express";
import { SalesReport } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const salesReport = new SalesReport(req.db);
        const salesReportData = await salesReport.get();
        res.send(salesReportData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
