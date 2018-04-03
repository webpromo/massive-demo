# [massive-js](https://massive-js.readthedocs.io/en/latest/)

## PRE-SETUP

### Step A: Create a Postgres database and install SQL Tabs

Follow the instructions on [https://github.com/statianzo/sql-setup](https://github.com/statianzo/sql-setup)

### Step B: Bootstrap and test your database
 
Copy the contents of [./schema.sql](https://github.com/statianzo/massive-demo/blob/master/schema.sql),
paste it into SQL Tabs and execute it.

Run a test query, `select * from injuries` and ensure you see some results.

#### Schema diagram

![schema](https://raw.githubusercontent.com/statianzo/massive-demo/master/diagram.png)

## Mini Project

### Step 1

Clone the repo (do not fork it).

### Step 2: Install the NPM modules

The necessary dependencies are already added in `package.json`.

```
npm install
```

### Step 3: Test it

Start your application by running:

```
npm start
``` 

Open [http://localhost:3000](http://localhost:3000) to test.

### Step 4: Import massive
 
In `server.js`, add to your list of imports:

```js
const massive = require('massive');
```

### Step 5: Connect to Postgres via massive

In `server.js` [add code to connect](https://github.com/dmfay/massive-js#quickstart)
to your database. Use the same connection string URI as SQL Tabs. Wrap the
`app.listen` call to ensure your database is connected before accepting
requests.

Add the connection as a `db` setting to the app. This will allow the
`connection` object to be accessed in requests through `req.app.get('db')`.

```js
const connectionString = 'postgres://localhost/mycooldatabase';

massive(connectionString).then(connection => {
  app.set('db', connection);
  app.listen(port, () => {
    console.log('Started server on port', port);
  });
});
```

Use `console.log(connection)` to test that you're properly connected to Postgres.
Remove it when you're confident it works.

### Step 6: Create a SQL Repository

massive-js works by converting your SQL queries, held in files, into JS functions.

For example, the following file, held in the `./db` directory of your project:

`db/getAllInjuries.sql`
```sql
SELECT * FROM injuries;
```

Yields the following function:

```js
db.getAllInjuries().then(injuries => {
  console.log(injuries) // injuries will contain an array of injuries
});
```

Create the `./db` directory, and add a file, `getAllIncidents.sql`
(_incidents_, not injuries).

### Step 7: Query Incidents

Now that you have a repository for SQL queries, add a query to your new file
that shows you retrieves the following pieces of information for every incident
in your database:

* `incidents.id`
* `incidents.state`
* `injuries.name`
* `affectedAreas.name`
* `causes.name`

Your query will require more than one join in a single statement (whoa!). When
your query is ready, test it in SQL Tabs.

### Step 8: Upgrade the GET Endpoint

Now that you have a way to return basic information about incidents of
injuries, upgrade the GET endpoint such that an HTTP request can return the
information to a client (like Angular) in your response:

Hint:

```js
db.getAllInjuries().then(injuries => {
  console.log(injuries) // injuries will contain an array of injuries
});
```

Using a client like [Postman](https://www.getpostman.com/) can help when making
test requests.

### Step 9: Up the Ante

If you've made it this far, great work. Now, upgrade your endpoint again, this
time accepting a query parameter, `state=UT`. When  submitted as part of the
GET request, return the results of a _different_ query, `db/getIncidentsByState.sql`.

Your query should return the same information, but only results that match the
value in the `state` query param.

Hint:

massive-js accepts arguments as part of your SQL using ${foo}, ${bar}, ...

```sql
SELECT * FROM Products
WHERE inStock = ${isAvailable} AND price < ${maxPrice};
```

Your arguments can be submitted as an object.

```js
db.getProducts({isAvailable: true, maxPrice:1000}).then(products => {
  // products is a results array
});
```

### Step 10: Create a New Incident

Upgrade the POST request to give yourself the ability to create a new incident.
Here's a sample request body for Postman:

```json
{
  "state": "WV",
  "injuryid": 1,
  "causeid": 5
}
```

### Step 11 (Optional): Consistent API

Let's keep our API consistent when reading and writing. After creating a new
incident, return the incident with the same fields as step 7:

* `incidents.id`
* `incidents.state`
* `injuries.name`
* `affectedAreas.name`
* `causes.name`

Hint:

See the [PostgreSQL INSERT docs](https://www.postgresql.org/docs/9.6/static/sql-insert.html)
on the `RETURNING` keyword.

Add `RETURNING id` to your `INSERT` statement from step 11.


### Step 12 (Optional): Server side rendering

Let's return some HTML by rendering on the server with React. For the root
route `/`, using the same query from step 10, render an HTML list of all
incidents. Here's some boilerplate HTML:

```html
<html>
<head>
  <title>Incidents</title>
</head>
<body>
  <h1>Incidents</h1>
  <table>
    <thead>
      <tr>
        <th>Id</th><th>State</th><th>Injury</th><th>Affected Area</th><th>Cause</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td><td>UT</td><td>Pulled Groin</td><td>Groin</td><td>Jumping jacks</td>
      </tr>
      <!-- one tr for each incident -->
    </tbody>
  </table>
</body>
</html>
```

Hint:

`require('react-dom/server').renderToString` will render React components as a
string. Returning that from express will be rendered as html.
