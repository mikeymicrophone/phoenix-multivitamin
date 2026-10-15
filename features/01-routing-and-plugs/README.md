# Routing and plugs

Router pipelines, plugs, scopes, forwards, and how a request is halted or passed on before a controller or LiveView ever sees it.

Official reference: [Routing and plugs](https://hexdocs.pm/phoenix/routing.html)

## Examples (0 of 13 bottled)

01. Admiralty Inlet tide gate — planned
02. Port Townsend hoist dispatch — planned
03. Friday Harbor customs shed — planned
04. Neah Bay entrance log — planned
05. Willapa seed barge office — planned
06. Kalama elevator tape — planned
07. Colman Dock shed — planned
08. Anacortes retort floor — planned
09. La Push skiff line — planned
10. Ballard lock house — planned
11. Quillayute chart desk — planned
12. Rosario watch floor — planned
13. Cape Flattery pipeline — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A browser pipeline that loads the station's request metadata |
| 02 | A plug that halts missing harbor credentials |
| 03 | Scoped routes that share a plug stack |
| 04 | Forwarding a path into another router |
| 05 | Plug options passed from the pipeline |
| 06 | A plug that assigns the active watch |
| 07 | Halt versus continue, and the conn that never reaches the action |
| 08 | API versus browser pipelines on one endpoint |
| 09 | Private conn fields versus assigns |
| 10 | Plug init/1 versus call/2 and compile-time options |
| 11 | A plug that reads the session and redirects |
| 12 | Nested scopes with a repeated prefix |
| 13 | Capstone: pipelines, halt, forward, and a scoped plug stack together |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
