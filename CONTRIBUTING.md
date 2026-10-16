# Contributing to Phoenix Multivitamin

Every scenario in this catalog follows the same conventions. The reference
scenario, [LiveView lifecycle and events · 01 · Akureyri night watch](features/06-liveview-lifecycle-and-events/01-akureyri-night-watch/),
illustrates those conventions. Preserve the conventions while choosing a
different code shape for each new scenario.

## The rules

### 1. Real names, always

This rule is not negotiable. Every module, function, assign, event, schema,
route, variable, and string a reader sees gets a name that means something
in the scenario's domain.

Never use `foo`, `bar`, `baz`, `qux`, `hello`, `hello world`, `example`,
`demo`, `test`, `thing`, `item1`, `my_live`, `some_value`, `data`, `x`, or
similar stand-ins. If you are tempted to write one, the scenario is not
concrete enough yet.

| Instead of | Write |
| --- | --- |
| `defmodule MyLive` | `defmodule AkureyriNightWatchLive` |
| `def handle_event("click", ...)` | `def handle_event("log_ice_pellets", ...)` |
| `assign(socket, :count, 0)` | `assign(socket, :tick_count, 0)` |
| `name: "Alice"` | `name: "Sólrún"` when Sólrún is the evening controller |

Content counts too: use believable sample data (a posted night watch, an
autoclave cure card, a Roadster flight plate), not lorem ipsum.

Test files are named `*_test.exs` because ExUnit loads them that way. The
word belongs to the runner, not to the domain. Inside the test, the names
are still the scenario's names.

### 2. One believable scenario per scenario folder

Each folder is one real-world job: a controller posting a night watch, a clerk
logging a cure card, a mechanic stamping a flight plate. Pick a scenario where
the feature is the natural tool, not one bent to fit it. Within a feature,
the thirteen scenarios should each show the feature in a different shape
rather than repeat one pattern.

### 3. Moderately complex to complex

Skip what the official docs already cover in a few lines. A scenario should
have enough moving parts to show the feature under realistic pressure: a
disconnected mount and a connected mount, an event that changes the board,
a follow-up that depends on the earlier assign. Order the thirteen slots
roughly from moderate to complex. Other Phoenix features may appear when a
real job would use them, but the folder's feature must be the star.

### 4. A short comment header that says what it teaches

- The LiveView or controller opens with a comment: the feature, slot number,
  and scenario title, followed by a short "Teaches:" list.
- The scenario's `README.md` repeats the "What it teaches" list for readers
  browsing on GitHub, plus a table of files and a "Try it" section.

Inside the code, comment only on constraints the code cannot show. Do not
narrate what the next line does.

### 5. Pinned to Phoenix 1.8 and LiveView 1.x

The root `mix.exs` pins `phoenix` to `~> 1.8.15` and `phoenix_live_view` to
`~> 1.2.0`, the versions these scenarios were checked against. SQLite is the
database, through `ecto_sqlite3`. Method names follow the guides on
[hexdocs.pm/phoenix](https://hexdocs.pm/phoenix) for that version.

When a new stable 1.8.x or LiveView 1.x release ships, bump it in one
commit: the `mix.exs`, the "Supplement Facts" in `README.md`, and this file.
Re-run `mix test`.

### 6. Thirteen per feature, and a quirked-safe folder

Each feature folder holds thirteen slots. A slot is bottled when its folder
contains a LiveView or controller, a test, and a README, and the slot's
`bottled: true` flag is set in that feature's `feature.exs`. Until then the
feature README lists the title as planned.

A future `quirked` branch will keep every Phoenix technique and the same
thirteen-per-feature structure, but swap the scenarios for more obscure,
esoteric, and playful subject matter: still readable and real, never
gibberish. Rule 1 applies there too.

To make that reskin a matter of renaming rather than restructuring, keep
each scenario self-contained:

- Scenario-specific names, copy, and sample data live only in that
  scenario's folder (its LiveView or controller, test, README, and HEEx),
  never in `lib/phoenix_multivitamin/catalog.ex`, `assets/css/multivitamin.css`,
  or the root README's how-to-run section.
- Slot titles for planned scenarios live in that feature's `README.md` and
  `feature.exs`, not in `lib/`.
- Put the Phoenix lesson in the structure (which callbacks run, in what
  order, what the test asserts about assigns and events), not in domain
  details, so a new domain can map onto the same structure one name at a
  time.
- `Catalog` reads `features/*/feature.exs`. It should not mention a station,
  a craft, or a cabinet.

## Idioms checklist

Read the sibling examples before adding a scenario. A different API call or
place name alone does not give readers a different Elixir idiom. Check the
feature as a whole; each scenario should teach a few well-chosen techniques.

- [ ] Extract repeated presentation setup with `assign_scenario/4` and
  `<.scenario_identity>` from
  [`ScenarioHelpers`](lib/phoenix_multivitamin_web/scenario_helpers.ex).
  Keep character names, craft, places, and sample content in the scenario folder.
- [ ] Vary function heads: destructure event params, match socket actions,
  and use guards for domain constraints. Include the rejected-input behavior.
- [ ] Choose among `with` for fallible steps, `case` for result shapes, and
  `cond` for predicates; avoid repeating the same callback skeleton.
- [ ] Vary collection work: filtered `for` comprehensions, captures,
  `Enum.reduce/3`, and pipelines that transform domain values.
- [ ] Mix maps, tuples, and `defstruct` with `@enforce_keys` where appropriate.
  Use protocols such as `String.Chars` when a domain type needs a shared operation;
  keep modules and protocol implementations in separate files.
- [ ] Vary streams beyond literal inserts: parameter-driven deletion with
  `stream_delete_by_dom_id/3`, reset, custom DOM IDs, update-only inserts,
  and positive versus negative limits. Always give stream children their DOM IDs.
- [ ] Vary async work: `assign_async`, `stream_async`, and `start_async` with
  explicit result handling. Show `<.async_result>` loading and failed slots,
  successful values, and empty results. Keep stream containers mounted while loading.
- [ ] Vary HEEx components with global attributes, named slots, slot attributes,
  and `:let`. Use `<Layouts.app flash={@flash} variant={:catalog}>` for catalog pages.
- [ ] Compose JS commands where useful. Demonstrate `JS.push` payload, target,
  and loading options, plus deliberate transitions, durations, or blocking options.
- [ ] Update the scenario's teaching header and README to match its final code.
  Keep existing behavior checks and add focused tests for new branches.
- [ ] Run touched features' tests while working, then `mix precommit` once for
  the final full suite. Keep the output to failures and the summary. Report any
  unavailable toolchain or check without claiming it passed.

## Folder layout

```
features/06-liveview-lifecycle-and-events/
  README.md
  feature.exs
  01-akureyri-night-watch/
    night_watch_live.ex
    night_watch_live_test.exs
    README.md
```

- Folder names are two-digit slot numbers plus a kebab-case scenario name.
- The LiveView or controller file lives in the scenario folder. Mix compiles
  `features/` through `elixirc_paths`. ExUnit loads `*_test.exs` from
  `features/` through `test_paths`. Mix also requires
  `features/test_helper.exs`; leave it as a no-op. `ExUnit.start/0` lives in
  `test/test_helper.exs`.
- Give a bottled slot `bottled: true` and `live_module: TheLiveModule` in
  `feature.exs`. `PhoenixMultivitamin.Catalog.draw_live_routes/0` draws the
  `live` route. Planned slots share `/features/:feature/:example`.
- Link `Layouts.catalog` for the shared look, but the scenario must still
  work if the stylesheet fails to load.
- Include a breadcrumb back to the catalog.

## Adding a scenario

1. Pick the next open slot in the feature's `README.md`. The planned titles
   are proposals; replace one if you have a better scenario.
2. Create the scenario folder using the conventions and idioms checklist above.
3. In the feature's `feature.exs`, set `bottled: true` and `live_module`.
4. In the feature's `README.md`, link the slot, mark it "available", and
   update the "N of 13 bottled" count.
5. In the root `README.md`, update that feature's "N of 13 bottled" count
   and the bottle's "Bottled" fact.
6. Run `mix test` on the new file, then `mix precommit` for the final suite.
