# Forms and changesets · 09 · Kashgar empty nil

Clerk Dilbar files endurance minutes for a Harbin Y-12 at Kashgar. An empty box casts to nil, not an empty string.

**What it teaches**

- Empty strings on an integer field cast to `nil`.

**Files**

| File | Role |
| --- | --- |
| [`endurance_card.ex`](endurance_card.ex) | Optional endurance minutes |
| [`empty_nil_live.ex`](empty_nil_live.ex) | Submit paints nil |
| [`empty_nil_live_test.exs`](empty_nil_live_test.exs) | Empty submit is nil |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/09-kashgar-empty-nil](http://localhost:4000/features/09-forms-and-changesets/09-kashgar-empty-nil).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/09-kashgar-empty-nil/empty_nil_live_test.exs
```
