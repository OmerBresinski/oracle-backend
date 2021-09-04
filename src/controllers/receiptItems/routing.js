import express from "express";
import { ReceiptItem } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const receiptItem = new ReceiptItem(req.db);
        const receiptItemData = await receiptItem.get();
        res.send(receiptItemData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
