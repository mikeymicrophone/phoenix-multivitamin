# Phoenix Multivitamin

Thirteen samples of healthy code for each feature of the
[Phoenix](https://www.phoenixframework.org) web framework. This is the Phoenix
sibling of
[Stimulus Multivitamin](https://github.com/mikeymicrophone/stimulus-multivitamin)
and
[RubyLLM Multivitamin](https://github.com/mikeymicrophone/rubyllm-multivitamin).

| Supplement Facts | |
| --- | --- |
| Serving size | 1 scenario |
| Servings per feature | 13 |
| Features | 25 |
| Scenarios | 325 |
| Bottled | 156 of 325 |
| Active ingredient | Phoenix 1.8.15 |
| LiveView | 1.2 |
| Database | SQLite (`ecto_sqlite3`) |
| Elixir | 1.20 |

## Why

The official Phoenix guides explain each feature well, but most of their
snippets are deliberately small: a greeter, a hello controller, a counter.
That is enough to learn the function names and not enough to see how a
feature holds up inside a real job of work.

Phoenix Multivitamin is a catalog of realistic scenarios: a shear gate at
Lukla, a Roadster flight plate at Payerne, a night watch at Akureyri. Each
feature gets thirteen of them, ranging from moderately complex to complex,
so you can see the same feature applied in thirteen different shapes.

Every scenario uses real, domain-meaningful names. You will not find
placeholder names here.

The bottle is just opening: 25 features, 13 scenarios each, 156 of 325 bottled.
The reference scenario that later ones copy is
[LiveView lifecycle and events · 01 · Akureyri night watch](features/06-liveview-lifecycle-and-events/01-akureyri-night-watch/).

## Run the examples locally

You need Elixir 1.17 or later (1.20 is what this bottle was opened with) and
Erlang/OTP 27 or later. SQLite is the database; there is no Postgres to start.

```sh
mix setup
mix phx.server
```

Then open [http://localhost:4000](http://localhost:4000) for the catalog.

`mix setup` fetches dependencies, creates the SQLite database, and builds
assets. `mix phx.server` serves the catalog and every bottled scenario.

Run the tests:

```sh
mix test
```

`mix test` creates the test database, migrates it, and runs every ExUnit
file under `test/` and `features/`.

Run the reference scenario on its own:

```sh
mix test features/06-liveview-lifecycle-and-events/01-akureyri-night-watch/night_watch_live_test.exs
```

## Layout

```
lib/phoenix_multivitamin/catalog.ex     reads each feature's feature.exs
lib/phoenix_multivitamin_web/           endpoint, router, catalog LiveView
features/
  06-liveview-lifecycle-and-events/
    README.md                           what the feature covers, and its 13 slots
    feature.exs                         titles and bottled flag (not in lib/)
    01-akureyri-night-watch/
      night_watch_live.ex               the LiveView
      night_watch_live_test.exs
      README.md
  01-routing-and-plugs/
  ...
```

Each bottled scenario is self-contained: the LiveView or controller, the
test, and the README live in that folder, and so do the domain names and the
copy. Shared files hold the catalog shelf and the vitamin-bottle look, not
the story.

## Features

1. [Routing and plugs](features/01-routing-and-plugs/) — 13 of 13 bottled
2. [Verified routes](features/02-verified-routes/) — 13 of 13 bottled
3. [Controllers and JSON](features/03-controllers-and-json/) — 13 of 13 bottled
4. [Function components and HEEx](features/04-function-components-and-heex/) — 13 of 13 bottled
5. [Core components and layouts](features/05-core-components-and-layouts/) — 13 of 13 bottled
6. [LiveView lifecycle and events](features/06-liveview-lifecycle-and-events/) — 13 of 13 bottled
7. [LiveView navigation](features/07-liveview-navigation/) — 13 of 13 bottled
8. [Async assigns](features/08-async-assigns/) — 13 of 13 bottled
9. [Forms and changesets](features/09-forms-and-changesets/) — 13 of 13 bottled
10. [Streams](features/10-streams/) — 13 of 13 bottled
11. [LiveComponents](features/11-live-components/) — 13 of 13 bottled
12. [JS commands](features/12-js-commands/) — 13 of 13 bottled
13. [Client hooks](features/13-client-hooks/) — 0 of 13 bottled
14. [Uploads](features/14-uploads/) — 0 of 13 bottled
15. [PubSub](features/15-pubsub/) — 0 of 13 bottled
16. [Presence](features/16-presence/) — 0 of 13 bottled
17. [Channels](features/17-channels/) — 0 of 13 bottled
18. [Ecto schemas and changesets](features/18-ecto-schemas-and-changesets/) — 0 of 13 bottled
19. [Ecto queries and contexts](features/19-ecto-queries-and-contexts/) — 0 of 13 bottled
20. [Ecto migrations and multis](features/20-ecto-migrations-and-multis/) — 0 of 13 bottled
21. [Auth and scopes](features/21-auth-and-scopes/) — 0 of 13 bottled
22. [Mailers with Swoosh](features/22-mailers-with-swoosh/) — 0 of 13 bottled
23. [Telemetry and LiveDashboard](features/23-telemetry-and-livedashboard/) — 0 of 13 bottled
24. [Gettext translations](features/24-gettext-translations/) — 0 of 13 bottled
25. [Testing](features/25-testing/) — 0 of 13 bottled

## Discoveries

Behaviors the official docs don't mention, found while bottling these
scenarios, are collected in [DISCOVERIES.md](DISCOVERIES.md). Phoenix
entries are grouped by feature. An entry lands there only after a test in
this repository has shown it.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the scenario conventions.

## License

[MIT](LICENSE) © Mike Schwab
