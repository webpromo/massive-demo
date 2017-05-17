var express = require('express');
var bodyParser = require('body-parser');
var massive = require('massive');
var _ = require('lodash');

var db = massive.connectSync({
  connectionString: 'your string'
});

var app = express();
app.use(bodyParser.json());

var port = 3000;

app.get('/', function(req, res) {
  var html = _.template(`
    <html>
      <body>
      <h1>My Injuries</h1>
      <table>
        <% injuries.forEach(function(injury) { %>
          <tr>
            <td><%= injury.name %></td>
            <td><%= injury.description %></td>
          </tr>
        <% }) %>
      </table>
      </body>
    </html>
  `);

  db.getAllInjuries(function(err, injuries) {
    res.send(html({injuries: injuries}));
  });
});

app.get('/incidents', function(req, res) {
  var state = req.query.state;
  var cause = req.query.cause;

  if (state) {
    db.getIncidentsByState([state], function(err, incidents) {
      console.log(err)
      res.send(incidents);
    });
  }
  else if (cause) {
    db.getIncidentsByCause([cause], function(err, incidents) {
      console.log(err)
      res.send(incidents);
    });
  }
  else {
    db.getAllIncidents(function(err, incidents) {
      res.send(incidents);
    });
  }
});

app.post('/incidents', function(req, res) {
  console.log(req.body)
  var incident = req.body;

  db.createIncident([
    incident.state,
    incident.injuryId,
    incident.causeId],
    function(err, result) {
      db.getIncident([result[0]], function(err, injury) {
        res.send(injury);
      });
    });

});

app.listen(port, function() {
  console.log("Started server on port", port);
});
