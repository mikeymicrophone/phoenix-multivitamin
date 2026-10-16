# Function components and HEEx · 10 · Milford Sound permits

Dispatcher Ngaio writes scenic and overnight slips at the Milford Sound
airstrip for the Cessna 185. The heading tag follows the permit class.
Party names are interspersed. `used_input?/1` stays false until the
dispatcher field is changed.

**What it teaches**

- `assign_new/3` computes the heading tag from `permit_class`.
- `<.dynamic_tag tag_name={@tag}>` renders `h3` for a scenic slip and `h2` overnight.
- `update/3` appends Hemi to the party. `<.intersperse>` puts a separator
  between names.
- `to_form/2` builds the dispatcher field. `used_input?/1` is false on first
  paint and true after `phx-change`.

**Files**

| File | Role |
| --- | --- |
| [`milford_permit_live.ex`](milford_permit_live.ex) | LiveView and the heading / party helpers |
| [`milford_permit_live_test.exs`](milford_permit_live_test.exs) | LiveViewTest for tag, party, and used_input? |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/10-milford-sound-permits](http://localhost:4000/features/04-function-components-and-heex/10-milford-sound-permits).
Switch to overnight. Add Hemi. Change the dispatcher name.

```sh
mix test features/04-function-components-and-heex/10-milford-sound-permits/milford_permit_live_test.exs
```
