# Function components and HEEx · 01 · Payerne Roadster flight plate

Nuri stamps flight plates for the Tesla Roadster flying car at Payerne.
Pneumatic thrusters, more whistle than roar. Each plate is a function
component: Starlight showroom, Workshop prototype, and Parade chase.
Required attrs are the livery and hangar bay. Puff count, kind, and whether
the thrusters are live have defaults. Kind is an atom limited by `values:`.

**What it teaches**

- `attr/3` declares types (`:string`, `:integer`, `:atom`, `:boolean`).
- `required: true` marks livery, hangar, and the DOM id. `default:` fills
  puff count (3 puffs), kind (`:showroom`), and `thrusters_live?` (true)
  when the caller omits them.
- `values: [:showroom, :prototype, :parade]` is the exhaustive list for
  `kind`. The press can stamp the showroom plate as parade without touching
  the prototype.
- Passing `puff_count={nil}` does **not** restore the default. The prototype
  whistle reads empty until the operator restores a number.

**Files**

| File | Role |
| --- | --- |
| [`flight_plate_live.ex`](flight_plate_live.ex) | LiveView and the `flight_plate/1` component |
| [`flight_plate_live_test.exs`](flight_plate_live_test.exs) | LiveViewTest for defaults, values, and nil |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/01-payerne-roadster-flight-plate](http://localhost:4000/features/04-function-components-and-heex/01-payerne-roadster-flight-plate).
Stamp the showroom plate as parade. Clear the prototype whistle.

```sh
mix test features/04-function-components-and-heex/01-payerne-roadster-flight-plate/flight_plate_live_test.exs
```
