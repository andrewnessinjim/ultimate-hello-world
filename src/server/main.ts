import express from "express"

const app = express();
const PORT = process.env.PORT || 3000;

app.set("view engine", "pug");

app.get("/", (req, res) => {
    res.render("index")
});

app.listen(PORT, () => {
    console.log(`Hello world running on port ${PORT}`);
});