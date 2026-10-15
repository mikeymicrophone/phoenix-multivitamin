# Function components and HEEx · 10 · Kaleetan trail permits

Ranger Thea writes day and overnight slips at Denny Creek for Kaleetan Peak
in the Alpine Lakes Wilderness. The heading tag follows the wilderness
class. Party names are interspersed. `used_input?/1` stays false until the
ranger field is changed.

**What it teaches**

- `assign_new/3` computes the heading tag from `wilderness_class`.
- `<.dynamic_tag tag_name={@tag}>` renders `h3` for a day slip and `h2` overnight.
- `update/3` appends Soren to the party. `<.intersperse>` puts a separator
  between names.
- `to_form/2` builds the ranger field. `used_input?/1` is false on first
  paint and true after `phx-change`.

**Files**

| File | Role |
| --- | --- |
| [`trail_permit_live.ex`](trail_permit_live.ex) | LiveView and the heading / party helpers |
| [`trail_permit_live_test.exs`](trail_permit_live_test.exs) | LiveViewTest for tag, party, and used_input? |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/10-kaleetan-trail-permits](http://localhost:4000/features/04-function-components-and-heex/10-kaleetan-trail-permits).
Switch to overnight. Add Soren. Change the ranger name.

```sh
mix test features/04-function-components-and-heex/10-kaleetan-trail-permits/trail_permit_live_test.exs
```
