const express = require('express');
const bodyParser = require('body-parser');
const massive = require('massive');
const React = require('react');
const {renderToString} = require('react-dom/server');

const connectionString = 'postgres://YOUR_CONNECTION_STRING';

const app = express();
app.use(bodyParser.json());

const port = 3000;

const InjuriesList = ({injuries}) => 
  <div>
    {injuries.map(injury => <div key={injury.id}>{injury.name}</div>)}
  </div>

app.get('/', (req, res) => {
  const db = req.app.get('db');
  db.getAllInjuries().then(injuries => {
    const html = renderToString(
      <InjuriesList injuries={injuries} />
    );
    res.send(html);
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
  const db = req.app.get('db');
  const incident = req.body;

  db.createIncident([
    incident.state,
    incident.injuryId,
    incident.causeId
  ]).then(results => {
    res.send(results[0]);
  });

});

massive(connectionString).then(db => {
  app.set('db', db);
  app.listen(port, () => {
    console.log('Started server on port', port);
  });
});
