# Verified routes

The ~p sigil, compile-time path checking, static paths, query strings, and interpolating dynamic segments without string-concatenated URLs.

Official reference: [Verified routes](https://hexdocs.pm/phoenix/Phoenix.VerifiedRoutes.html)

## Examples (13 of 13 bottled)

01. [Alki Point signal flags](01-alki-point-signal-flags/) — available
02. [Bush Point range board](02-bush-point-range-board/) — available
03. [Patos Island fog logger](03-patos-island-fog-logger/) — available
04. [Turn Point light book](04-turn-point-light-book/) — available
05. [West Point current card](05-west-point-current-card/) — available
06. [Browns Point fog desk](06-browns-point-fog-desk/) — available
07. [Point No Point staff gate](07-point-no-point-staff-gate/) — available
08. [Smith Island tide drum](08-smith-island-tide-drum/) — available
09. [Point Robinson bell relay](09-point-robinson-bell-relay/) — available
10. [Edmonds ramp tickets](10-edmonds-ramp-tickets/) — available
11. [Mukilteo fare banner](11-mukilteo-fare-banner/) — available
12. [Deception Pass fault line](12-deception-pass-fault-line/) — available
13. [Fort Worden guard house](13-fort-worden-guard-house/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A ~p path to a station page, checked at compile time |
| 02 | Query strings built with the sigil rather than concatenated |
| 03 | Dynamic segments interpolated into a verified path |
| 04 | Static asset paths through ~p |
| 05 | A verified path used from a controller redirect |
| 06 | A verified path used from a LiveView patch and push_navigate |
| 07 | Optional query params omitted versus present |
| 08 | URL generation with a custom host from the endpoint, a URI, or the conn |
| 09 | Verified routes inside a mailer template |
| 10 | Forwarded routes and the prefix the sigil must include |
| 11 | A path helper retired in favor of ~p wrapped in a named function |
| 12 | Compile-time warning when a route is removed, documented in the README |
| 13 | Capstone: controller, LiveView, and mailer all share one ~p path |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot in another feature.
