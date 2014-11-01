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

