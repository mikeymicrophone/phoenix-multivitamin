# JS commands · 03 · Kutaisi lamp fade

Clerk Tamari fades the threshold lamp on a Embraer ERJ-145.

**What it teaches**

- `JS.transition/1` names the fade class and the lamp.

**Files**

| File | Role |
| --- | --- |
| [`lamp_fade_live.ex`](lamp_fade_live.ex) | transition fade-lamp |
| [`lamp_fade_live_test.exs`](lamp_fade_live_test.exs) | The command is on the button |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/03-kutaisi-lamp-fade](http://localhost:4000/features/12-js-commands/03-kutaisi-lamp-fade).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/03-kutaisi-lamp-fade/lamp_fade_live_test.exs
```
