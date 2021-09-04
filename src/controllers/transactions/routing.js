import express from "express";
import { Transaction } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const transaction = new Transaction(req.db);
        const transactions = await transaction.get();
        res.send(transactions);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
