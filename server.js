const express = require('express');
const bodyParser = require('body-parser');
const massive = require('massive');

const connectionString = 'postgres://YOUR_CONNECTION_STRING';

const app = express();
app.use(bodyParser.json());

const port = 3000;

app.get('/', (req, res) => {
  const db = req.app.get('db');
  db.getAllInjuries().then(injuries => {
    res.send(injuries);
  });
});

app.get('/incidents', (req, res) => {
  const db = req.app.get('db');
  const state = req.query.state;
  if (state) {
    db.getIncidentsByState([state]).then(incidents => {
      res.send(incidents);
    });
  }
  else {
    db.getAllIncidents().then(incidents => {
      res.send(incidents);
    });
  }
});

app.post('/incidents', (req, res) => {
  const incident = req.body;
  const db = req.app.get('db');

  db.createIncident([
    incident.state,
    incident.injuryId,
    incident.causeId
  ]).then(result => {
    res.send(result);
  });
});

massive(connectionString).then(db => {
  app.set('db', db);
  app.listen(port, () => {
    console.log('Started server on port', port);
  });
});
