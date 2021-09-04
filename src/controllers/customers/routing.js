import express from "express";
import { Customer } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const customer = new Customer(req.db);
        const customers = await customer.get();
        res.send(customers);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
