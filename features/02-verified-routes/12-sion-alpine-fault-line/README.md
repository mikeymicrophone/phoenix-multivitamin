# Verified routes · 12 · Sion alpine fault line

Tech Remo reads the steel at the Sion alpine strip for the Pilatus PC-6
Porter. The current span is a verified `~p`. The collapsed-ridge path was
pulled from the router. Compiling it now warns. That warning lives in the
test, not in the LiveView — `mix precommit` compiles with
`--warnings-as-errors`.

**What it teaches**

- After compile, `@after_verify` asks the router whether the materialized
  path exists. A miss is:

  `warning: no route path for PhoenixMultivitaminWeb.Router matches ~p"/.../collapsed-ridge"`

- Dynamic interpolations are replaced with `"1"` for that check. A path
  like `~p"/features/.../fault-line/#{span}"` still has enough static
  segments to miss `/collapsed-ridge` and warn.
- Adjacent dynamics (`~p"/features/#{feature}/#{span}"`) do **not** warn.
  The stand-in looks like `/features/1/1`, which matches
  `/features/:feature/:example`. A removed folder can hide in there.
- Do not leave a known-bad `~p` in `lib/` or `features/` compiled modules.
  Capture it in a test that compiles a throwaway module.

**Files**

| File | Role |
| --- | --- |
| [`fault_line_live.ex`](fault_line_live.ex) | Current span; documents the warning |
| [`fault_line_live_test.exs`](fault_line_live_test.exs) | Compiles retired and dynamic paths |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/12-sion-alpine-fault-line](http://localhost:4000/features/02-verified-routes/12-sion-alpine-fault-line).
The board shows the warning the test captures.

```sh
mix test features/02-verified-routes/12-sion-alpine-fault-line/fault_line_live_test.exs
```
