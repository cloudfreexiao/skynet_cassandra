# skynet_cassandra


A pure Lua client library for Apache Cassandra (2.x/3.x), compatible with
[skynet].

## Table of Contents

- [Features](#features)
- [Usage](#usage)

## Features

This library offers 2 modules: a "single host" module, compatible with PUC Lua 5.1/5.2,
LuaJIT and OpenResty, which allows your application to connect itself to a
given Cassandra node, and a "cluster" module, only compatible with OpenResty
which adds support for multi-node Cassandra datacenters.

- Single host `cassandra` module:
  - no dependencies
  - support for Cassandra 2.x and 3.x
  - simple, prepared, and batch statements
  - pagination (manual and automatic via Lua iterators)
  - SSL client-to-node connections
  - client authentication
  - leverage the non-blocking, reusable cosocket API in ngx_lua (with
    automatic fallback to LuaSocket in non-supported contexts)

- Cluster `resty.cassandra.cluster` module:
  - all features from the `cassandra` module
  - cluster topology discovery
  - advanced querying options
  - configurable policies (load balancing, retry, reconnection)
  - optimized performance for OpenResty

[Back to TOC](#table-of-contents)

## Usage

Single host module (Lua and OpenResty):

```lua
local cassandra = require "cassandra"

assert(peer:connect ({
    host = "127.0.0.1",
  port = 9042,
  keyspace = "cloudfreexiao"
})

assert(peer:execute("INSERT INTO users(id, name, age) VALUES(?, ?, ?)", {
  cassandra.uuid("1144bada-852c-11e3-89fb-e0b9a54a6d11"),
  "John O Reilly",
  42
}))

local rows = assert(peer:execute "SELECT * FROM users")

local user = rows[1]
print(user.name) -- John O Reilly
print(user.age)  -- 42

peer:close()
```

