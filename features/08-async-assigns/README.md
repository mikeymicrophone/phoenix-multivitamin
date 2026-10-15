# Async assigns

assign_async, start_async, handle_async, and the loading, ok, and failed shapes of an async result that must not block mount.

Official reference: [Async assigns](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#assign_async/3)

## Examples (0 of 13 bottled)

01. Dungeness sounding halt — planned
02. Strait barometer card — planned
03. Portage Head current fetch — planned
04. Hein Bank swell table — planned
05. Race Rocks visibility — planned
06. Protection Island radar overlay — planned
07. Smith Island barometer fetch — planned
08. Viti Rocks current atlas — planned
09. Trial Island fog fetch — planned
10. Discovery Island swell — planned
11. Sisters Islands tide fetch — planned
12. Chatham Islands wind aloft — planned
13. Juan de Fuca forecast desk — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | assign_async/3 started from mount |
| 02 | The loading slot while the sounding is out |
| 03 | The ok tuple and the board it fills |
| 04 | The failed tuple and the retry event |
| 05 | start_async/3 for a task that is not an assign |
| 06 | handle_async/3 receiving the result |
| 07 | Several async assigns in flight together |
| 08 | Canceling an async when the watch changes |
| 09 | Async that reads from the Repo without blocking render |
| 10 | Resetting an async assign back to loading |
| 11 | An async linked to a process that exits |
| 12 | Timeouts and the failed reason you actually get |
| 13 | Capstone: two boards, a failure, and a retry on one desk |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
