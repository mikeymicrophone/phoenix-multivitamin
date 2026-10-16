# Routing and plugs

Router pipelines, plugs, scopes, forwards, and how a request is halted or passed on before a controller or LiveView ever sees it.

Official reference: [Routing and plugs](https://hexdocs.pm/phoenix/routing.html)

## Examples (13 of 13 bottled)

01. [Lukla shear gate](01-lukla-shear-gate/) — available
02. [Tromsø SAR hoist](02-tromso-sar-hoist/) — available
03. [Incheon bonded shed](03-incheon-bonded-shed/) — available
04. [Paro inbound log](04-paro-inbound-log/) — available
05. [Shannon avgas office](05-shannon-avgas-office/) — available
06. [Changi hydrant tape](06-changi-hydrant-tape/) — available
07. [Barra beach shed](07-barra-beach-shed/) — available
08. [Finkenwerder jig floor](08-finkenwerder-jig-floor/) — available
09. [Oostwold balloon line](09-oostwold-balloon-line/) — available
10. [Kiruna de-ice pad](10-kiruna-deice-pad/) — available
11. [Bergen briefing desk](11-bergen-briefing-desk/) — available
12. [Santa Maria oceanic floor](12-santa-maria-oceanic-floor/) — available
13. [Ushuaia austral pipeline](13-ushuaia-austral-pipeline/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A router pipeline plug, then controller function plugs, stamping one request |
| 02 | A module plug that halts missing hoist credentials before the dispatcher |
| 03 | Sibling scopes sharing resources, with path params that stay strings |
| 04 | `forward/2` into another router: `script_name`, `path_info`, `request_path` |
| 05 | Plug options from the controller pipeline, transformed in `init/1` |
| 06 | Pipeline assigns on a controller; `assign_new/3` copies them only on the disconnected render |
| 07 | Halt versus continue, and the later plug that never runs |
| 08 | Browser versus API pipelines, `accepts/2`, and a 406 |
| 09 | `assign/3` for the template versus `put_private/3` that the board cannot see |
| 10 | `init/1` versus `call/2`, and `:runtime` plug_init_mode in test |
| 11 | A session plug that redirects; without `halt/1` the action still runs |
| 12 | Nested scopes, concatenated prefixes, additive `pipe_through` |
| 13 | Capstone: pipelines, halt, forward, nested scopes, and resources together |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot in another feature.
