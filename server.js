const express = require('express');
const bodyParser = require('body-parser');
const massive = require('massive');

// test to see if Massive works
const connectionString = "postgres://?ssl=true"

const app = express();
app.use(bodyParser.json());

const port = 3000;

app.set('cool','jason'); /// the two names don't matter, just must use elsewhere  // creates a value you can use elsewhere.

app.get('/', (req, res) => {
  const db = req.app.get('db');  
  db.getAllInjuries().then(injuries => {  // adds a method to db that we can call later
    res.send(injuries);  
  })   

});

app.get('/incidents', (req, res) => {
  res.send([]);
});

app.post('/incidents', (req, res) => {
  res.send({id: 123});
});

massive(connectionString).then(connection =>{
  app.set('db',connection);  // our db connection is the 'db' setting 
  app.listen(port, () => {
    console.log('Started server on port', port);
  });
})
