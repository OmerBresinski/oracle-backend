import express from "express";
import { TransactionsReport } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const transactionsReport = new TransactionsReport(req.db);
        const transactionsReportData = await transactionsReport.get();
        res.send(transactionsReportData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
