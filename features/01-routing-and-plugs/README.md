# Routing and plugs

Router pipelines, plugs, scopes, forwards, and how a request is halted or passed on before a controller or LiveView ever sees it.

Official reference: [Routing and plugs](https://hexdocs.pm/phoenix/routing.html)

## Examples (13 of 13 bottled)

01. [Admiralty Inlet tide gate](01-admiralty-inlet-tide-gate/) — available
02. [Port Townsend hoist dispatch](02-port-townsend-hoist-dispatch/) — available
03. [Friday Harbor customs shed](03-friday-harbor-customs-shed/) — available
04. [Neah Bay entrance log](04-neah-bay-entrance-log/) — available
05. [Willapa seed barge office](05-willapa-seed-barge-office/) — available
06. [Kalama elevator tape](06-kalama-elevator-tape/) — available
07. [Colman Dock shed](07-colman-dock-shed/) — available
08. [Anacortes retort floor](08-anacortes-retort-floor/) — available
09. [La Push skiff line](09-la-push-skiff-line/) — available
10. [Ballard lock house](10-ballard-lock-house/) — available
11. [Quillayute chart desk](11-quillayute-chart-desk/) — available
12. [Rosario watch floor](12-rosario-watch-floor/) — available
13. [Cape Flattery pipeline](13-cape-flattery-pipeline/) — available

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
