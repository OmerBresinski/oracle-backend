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

router.post("/", async (req, res) => {
    try {
        const order = new Order(req.db);
        const newOrderID = await order.create(req.body.customerID, req.body.itemIDs);
        res.send({ orderID: newOrderID });
    } catch (ex) {
        console.log(ex);
        res.status(400).json(ex.message);
    }
});

router.post("/cancel", async (req, res) => {
    try {
        const order = new Order(req.db);
        const success = await order.cancel(req.body.orderID);
        res.send({ success });
    } catch (ex) {
        console.log(ex);
        res.status(400).json(ex.message);
    }
});

export default router;
