var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.json());

var port = 3000;

app.get('/', function(req, res) {
  res.send('Hello World!');
});

app.get('/incidents', function(req, res) {
  res.send({incidents: []});
});

app.post('/incidents', function(req, res) {
  res.send({id: 123});
});

app.listen(port, function() {
  console.log("Started server on port", port);
});
