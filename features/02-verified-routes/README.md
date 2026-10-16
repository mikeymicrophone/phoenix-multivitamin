# Verified routes

The ~p sigil, compile-time path checking, static paths, query strings, and interpolating dynamic segments without string-concatenated URLs.

Official reference: [Verified routes](https://hexdocs.pm/phoenix/Phoenix.VerifiedRoutes.html)

## Examples (13 of 13 bottled)

01. [La Ferté-Alais signal flags](01-la-ferte-alais-signal-flags/) — available
02. [Innsbruck approach board](02-innsbruck-approach-board/) — available
03. [Ilulissat ice logger](03-ilulissat-ice-logger/) — available
04. [Le Bourget light book](04-le-bourget-light-book/) — available
05. [Funchal wind card](05-funchal-wind-card/) — available
06. [Courchevel altimeter desk](06-courchevel-altimeter-desk/) — available
07. [Gibraltar staff gate](07-gibraltar-staff-gate/) — available
08. [Mataveri METAR drum](08-mataveri-metar-drum/) — available
09. [Accra slot relay](09-accra-slot-relay/) — available
10. [Addis ramp tickets](10-addis-ramp-tickets/) — available
11. [Nairobi Wilson fare banner](11-nairobi-wilson-fare-banner/) — available
12. [Sion alpine fault line](12-sion-alpine-fault-line/) — available
13. [Luqa QRA guard house](13-luqa-qra-guard-house/) — available

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
