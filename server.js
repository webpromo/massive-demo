var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.json());

var port = 3000;

app.get('/incidents', function(req, res) {
  console.log('GET /incidents');
});

app.post('/incidents', function(req, res) {
  console.log('POST /incidents');
});

app.listen(port, function() {
  console.log("Started server on port", port);
});
