import express from "express";
import cors from "cors";
import * as Route from "./src/controllers/index.js";
import { dbConnection } from "./db.js";

const PORT = 4000;
const app = express();
app.use(cors());
app.use(dbConnection);
app.use("/items", Route.items);
app.use("/orders", Route.orders);
app.use("/receipts", Route.receipt);
app.use("/warehouse", Route.warehouse);
app.use("/inventory", Route.inventory);
app.use("/customers", Route.customers);
app.use("/orderitems", Route.orderItems);
app.use("/receiptitems", Route.receiptItems);
app.use("/transactions", Route.transactions);
app.use("/inventoryinsufficiency", Route.inventoryInsufficiency);

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
