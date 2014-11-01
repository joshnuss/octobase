Octobase
========

A relational/document hybrid database using Elixir

## Main features

- No schema is needed up front, only define schema when you want to specify relationship, attribute constraints or default value
- BSON as the internal storage construct
- Support unique and non-unique indexes
- Insert and update with JSON/REST or SQL (data transfered over wire in BSON format)
- Query with SQL joins and conditions (syntax is slightly different that SQL92)
- Aggregate functions (group by, min, max, count, etc)
- Full query pipeline: Query parser, query planner, explain plan, query executor, query parser cache
- ACID (atomic consistent isolated durable)
- Distributed (replication / multi-master & master-slave)
- Auto-sharding
- Multi-tenant (using seperate schemas)
- Support querying using REST (json), TCP (bson) & websocket endpoints
- Maps well with traditional ORMs like rails activerecord
- Can work just like mongodb or firebase
- 100% open source

## Command Interfaces

There 3 ways to communicate with Octobase:

- Using the CLI `octo`
- Via TCP protocol (uses BSON format)
- Via HTTP/REST protocol (uses JSON format)
- Via Websockets (uses JSON format)

## Querying

Queries are done with a query language very similar to SQL, the main difference is that it understands json.

```
SELECT {name: people.name, age: year(today() - people.birthdate)}
FROM people
WHERE birthdate < date('1990-01-01')
```

You can also include relationships via the INCLUDE clause

```
SELECT * FROM people INCLUDE cities
```

```json
[
  {name: "John", city: {name: "New York", state: "NY"}},
  {name: "Jane", city: {name: "Los Angeles", state: "CA"}},
  ...
]
```

### Inserting

Data is inserted in a JSON format

```
INSERT INTO people
{name: "Jane", birthdate: date('1980-01-01')}
```

Relationships can also be inserted at the same time, in this example a city record is also created

```
INSERT INTO people
{name: "Jane", city: {name: "Los Angeles", state: "CA"}}
```

If the `id` of the city is known, that can be used instead

```
INSERT INTO people
{name: "Jane", _city: 1234}
```

Bulk inserts are done with arrays of JSON

```
INSERT INTO people
[
  {name: "Jane", birthdate: date('1980-01-01')},
  {name: "John", birthdate: date('1980-01-01')}
]
```

### Updating

```
UPDATE people SET {name: "John"} WHERE name = 'Jane'
```

### Deleting

```
DELETE FROM people WHERE name = 'Jane'
```
