import express from "express";
import { Item } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const item = new Item(req.db);
        const items = await item.get();
        res.send(items);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
