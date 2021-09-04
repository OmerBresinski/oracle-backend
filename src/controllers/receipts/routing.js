import express from "express";
import { Receipt } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const receipt = new Receipt(req.db);
        const receiptData = await receipt.get();
        res.send(receiptData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
