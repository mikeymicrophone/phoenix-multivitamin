# Auth and scopes

current_scope, assign_scope, scoped routes, and the Phoenix 1.8 scope pattern that keeps a controller's data from leaking across stations.

Official reference: [Auth and scopes](https://hexdocs.pm/phoenix/scopes.html)

## Examples (0 of 13 bottled)

01. Córdoba Mezquita scope — planned
02. Arequipa Misti scope — planned
03. La Paz altiplano scope — planned
04. Sucre white-city scope — planned
05. Santa Cruz oriente scope — planned
06. Asunción Paraguay scope — planned
07. Montevideo Rambla scope — planned
08. Córdoba Sierras scope — planned
09. Valdivia Los Ríos scope — planned
10. Concepción Biobío scope — planned
11. Iquique nitrate scope — planned
12. Arica Morro scope — planned
13. Cartagena walled scope — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A scope struct for the controller and the station |
| 02 | assign_scope in a plug |
| 03 | live_session that requires a scope |
| 04 | Context functions that take the scope as the first argument |
| 05 | Queries scoped by station_id, never a raw all/1 |
| 06 | A hook that redirects when the scope is missing |
| 07 | on_mount {Scope, :require} |
| 08 | Public versus authenticated live_session |
| 09 | A token that becomes a scope, not a user assign |
| 10 | Scope in verified routes (optional segments) |
| 11 | Testing with a scope in ConnCase |
| 12 | A controller who can read one station and not the next |
| 13 | Capstone: plug, live_session, scoped context, and a refused board |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
