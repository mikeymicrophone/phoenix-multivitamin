# Telemetry and LiveDashboard

telemetry execute, metrics, periodic measurements, and LiveDashboard pages that show a station's pulse rather than a blank VM.

Official reference: [Telemetry and LiveDashboard](https://hexdocs.pm/phoenix_live_dashboard/Phoenix.LiveDashboard.html)

## Examples (0 of 13 bottled)

01. Watch log metrics — planned
02. Retort cook duration — planned
03. Ferry sailing counters — planned
04. Lock chamber cycle time — planned
05. Fog signal blast counts — planned
06. Lens rotation span — planned
07. Hatchery tray gauges — planned
08. Seed press throughput — planned
09. Pilot boarding wait — planned
10. Net loft mend duration — planned
11. Buoy paint cure gauge — planned
12. Chart desk open tickets — planned
13. Strait radio check metrics — planned

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
