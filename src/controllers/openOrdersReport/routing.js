import express from "express";
import { OpenOrdersReport } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const openOrdersReport = new OpenOrdersReport(req.db);
        const openOrdersReportData = await openOrdersReport.get();
        res.send(openOrdersReportData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
