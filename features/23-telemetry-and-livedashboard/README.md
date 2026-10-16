# Telemetry and LiveDashboard

telemetry execute, metrics, periodic measurements, and LiveDashboard pages that show a station's pulse rather than a blank VM.

Official reference: [Telemetry and LiveDashboard](https://hexdocs.pm/phoenix_live_dashboard/Phoenix.LiveDashboard.html)

## Examples (0 of 13 bottled)

01. Kisumu Winam metrics — planned
02. Mombasa Moi duration — planned
03. Pemba clove counters — planned
04. Kilimanjaro Kibo cycle — planned
05. Lilongwe lake counts — planned
06. Lusaka Copperbelt span — planned
07. Harare Highveld gauges — planned
08. Gaborone Kalahari throughput — planned
09. Maputo Indian Ocean wait — planned
10. Beira Sofala duration — planned
11. Toamasina vanilla gauge — planned
12. Réunion Piton tickets — planned
13. Mayotte lagoon metrics — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | :telemetry.execute/3 from a context write |
| 02 | A counter metric in Telemetry.Metrics |
| 03 | A distribution for duration |
| 04 | last_value for a gauge like visibility |
| 05 | periodic measurements in the telemetry module |
| 06 | LiveDashboard metrics: page |
| 07 | A custom LiveDashboard page |
| 08 | Attaching a handler versus a metric |
| 09 | The stop event of a span |
| 10 | Tag values that are station names, not user ids |
| 11 | VM metrics that already ship with Phoenix |
| 12 | Repo telemetry already emitted by Ecto |
| 13 | Capstone: custom event, metric, and a dashboard card |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
