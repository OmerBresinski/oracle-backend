import express from "express";
import { Order } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const order = new Order(req.db);
        const orderData = await order.get();
        res.send(orderData);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
