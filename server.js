const express = require('express');
const bodyParser = require('body-parser');
const React = require('react');
const {renderToString} = require('react-dom/server');

const app = express();
app.use(bodyParser.json());

const port = 3000;

app.get('/', (req, res) => {
  res.send(
    renderToString(
      <html>
        <head>
          <title>Title</title>
        </head>
        <body>
          <h1>Dude</h1>
        </body>
      </html>
    )
  );
});

app.get('/incidents', (req, res) => {
  res.send([]);
});

app.post('/incidents', (req, res) => {
  res.send({id: 123});
});

app.listen(port, () => {
  console.log('Started server on port', port);
});
