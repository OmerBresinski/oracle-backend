import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import * as Controllers from "./src/controllers/index.js";
import { dbConnection } from "./db.js";

const PORT = 4000;
const app = express();
app.use(cors());
app.use(dbConnection);
app.use(bodyParser.json());
app.use("/items", Controllers.items);
app.use("/orders", Controllers.orders);
app.use("/receipts", Controllers.receipt);
app.use("/warehouse", Controllers.warehouse);
app.use("/inventory", Controllers.inventory);
app.use("/customers", Controllers.customers);
app.use("/orderitems", Controllers.orderItems);
app.use("/receiptitems", Controllers.receiptItems);
app.use("/transactions", Controllers.transactions);
app.use("/salesreport", Controllers.salesReport);
app.use("/inventoryreport", Controllers.inventoryReport);
app.use("/openordersreport", Controllers.openOrdersReport);
app.use("/transactionsReport", Controllers.transactionsReport);
app.use("/inventoryinsufficiency", Controllers.inventoryInsufficiency);

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
