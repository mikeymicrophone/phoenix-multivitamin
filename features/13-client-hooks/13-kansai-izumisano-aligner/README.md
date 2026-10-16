# Client hooks · 13 · Kansai Izumisano aligner

Docking engineer Haruka checks paired nosewheel sensors for the Boeing 787-9 at Kansai, rejecting stale measurements before the next alignment.

**What it teaches**

- The capstone combines a mounted handshake, `pushEvent` replies, `push_event/handleEvent`, and listener cleanup.
- An enforced-key struct owns sensor validation; its separate `String.Chars` implementation formats the stand report.
- Socket destructuring guards a sequence number; `with` handles sensor failures without advancing it.

**Files**

| File | Role |
| --- | --- |
| [`izumisano_aligner_live.ex`](izumisano_aligner_live.ex) | LiveView and colocated hook |
| [`izumisano_aligner_live_test.exs`](izumisano_aligner_live_test.exs) | Hook contract and server behavior |
| [`kansai_alignment.ex`](kansai_alignment.ex) | Enforced-key sensor model and validation |
| [`alignment_chars.ex`](alignment_chars.ex) | Separate String.Chars protocol implementation |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/13-kansai-izumisano-aligner](http://localhost:4000/features/13-client-hooks/13-kansai-izumisano-aligner).

Measure sensors at 2 mm and 4 mm, then at -12 mm and 12 mm. Stow and redeploy the
instrument; the server retains its last report and sequence.

```sh
mix test features/13-client-hooks/13-kansai-izumisano-aligner/izumisano_aligner_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
