var express = require('express');
var bodyParser = require('body-parser');
var massive = require('massive');

var db = massive.connectSync({
  connectionString : 'postgres://postgres:postgres@localhost/massive_demo'
});

console.log(db)

var app = express();
app.use(bodyParser.json());

var port = 3000;

app.get('/', function(req, res) {
  db.get_all_injuries(function(err, injuries) {
    res.send(injuries);
  });
});

app.get('/incidents', function(req, res) {
  var state = req.query.us_state;

  if (state) {
    db.get_incidents_by_state([state], function(err, incidents) {
      res.send(incidents);
    });
  }
  else {
    db.get_all_incidents(function(err, incidents) {
      res.send(incidents);
    });
  }
});

app.post('/incidents', function(req, res) {
  res.send({id: 123});
});

app.listen(port, function() {
  console.log("Started server on port", port);
});
