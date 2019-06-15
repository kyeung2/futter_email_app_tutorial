const express = require("express")
const contacts = require("./contacts.json");
const app = express()

app.get("/", function (req, res) {
  res.send("Flutter in Practice")
})



const delay = ms => new Promise(resolve => setTimeout(resolve, ms));
app.get("/contacts",  async (req, res) => {
  const { q } = req.query;
  console.log(`query is: ${q}`)
  let r = contacts;
  if (q) {

    if( q === "le" ){
      await delay(2000);
    }

    r = contacts.filter(({ name }) => name.match(q))
    console.log(`number of filtered results: ${r.length}`)
  } else {
    console.log(`number of results: ${r.length}`)
  }
  res.json(r)
})


app.listen(3000)