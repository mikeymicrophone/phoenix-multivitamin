# Core components and layouts · 12 · Billund apron card

Marshal Mads parks a CRJ900 on the LEGO apron. The shared catalog layout
names no station. Billund, Mads, and the CRJ900 live only on this card.

**What it teaches**

- A layout that does not mention any scenario name.
- Station nouns stay in the scenario folder.
- The brand is still "Phoenix Multivitamin".

**Files**

| File | Role |
| --- | --- |
| [`apron_card_live.ex`](apron_card_live.ex) | Card copy |
| [`apron_card_live_test.exs`](apron_card_live_test.exs) | Brand versus card names |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/12-billund-apron-card](http://localhost:4000/features/05-core-components-and-layouts/12-billund-apron-card).

```sh
mix test features/05-core-components-and-layouts/12-billund-apron-card/apron_card_live_test.exs
```
