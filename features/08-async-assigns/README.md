# Async assigns

assign_async, start_async, handle_async, and the loading, ok, and failed shapes of an async result that must not block mount.

Official reference: [Async assigns](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#assign_async/3)

## Examples (13 of 13 bottled)

01. [Puerto Natales wind fetch](01-puerto-natales-wind-fetch/) — available
02. [Mawlamyine monsoon loading](02-mawlamyine-monsoon-loading/) — available
03. [Quetta ok board](03-quetta-ok-board/) — available
04. [Van icing retry](04-van-icing-retry/) — available
05. [Goma ash task](05-goma-ash-task/) — available
06. [Nouakchott harmattan handle](06-nouakchott-harmattan-handle/) — available
07. [Upernavik triple fetch](07-upernavik-triple-fetch/) — available
08. [Aktau cancel watch](08-aktau-cancel-watch/) — available
09. [Kangerlussuaq sounding shelf](09-kangerlussuaq-sounding-shelf/) — available
10. [Tamanrasset density reset](10-tamanrasset-density-reset/) — available
11. [Norilsk hoist exit](11-norilsk-hoist-exit/) — available
12. [Walvis Bay timeout](12-walvis-bay-timeout/) — available
13. [Balmaceda capstone desk](13-balmaceda-capstone-desk/) — available

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
