import express from "express";
import { Storage } from "../../services/index.js";
const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const storage = new Storage(req.db);
        const storageItems = await storage.get();
        res.send(storageItems);
    } catch (ex) {
        res.status(400).json(ex.message);
    }
});

export default router;
