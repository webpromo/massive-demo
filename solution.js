var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');
var massive = require('massive');

var app = express();
app.use(bodyParser.json());

var port = 3000;

var db = massive.connectSync({db: "massive_demo_09"});

function printErr(err) {
  if (err) {
    console.log("Error:", err)
  }
}

app.get('/incidents', function(req, res) {
  if (req.query.by == "cause") {
    db.get_incidents_by_cause([req.query.cause], function(err, incidents) {
      printErr(err);
      res.json(incidents);
    });
  } else {
    db.get_all_incidents(function(err, incidents) {
      printErr(err);
      res.json(incidents);
    });
  }
});

app.post('/incidents', function(req, res) {
  db.create_incident(req.body.us_state, req.body.injury_id, req.body.cause_id, function(err, resp) {
    res.json(resp); // Why no data?
  });
});

app.listen(port, function() {
  console.log("Started server on port", port);
});
