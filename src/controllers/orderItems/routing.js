import express from "express";
import { OrderItem } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const orderItem = new OrderItem(req.db);
        const orderItemData = await orderItem.get();
        res.send(orderItemData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
