# JS commands · 03 · Kutaisi lamp fade

Clerk Tamari fades the threshold lamp on a Embraer ERJ-145.

**What it teaches**

- `JS.transition/2` names the transition and the lamp.
- A transition tuple names start and finish classes, with `time: 700` and `blocking: false`.

**Files**

| File | Role |
| --- | --- |
| [`lamp_fade_live.ex`](lamp_fade_live.ex) | Timed, nonblocking transition |
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
