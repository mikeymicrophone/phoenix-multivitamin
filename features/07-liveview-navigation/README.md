# LiveView navigation

patch, navigate, live_redirect, handle_params/3 on an already-mounted view, and the difference between a dead render and a live patch.

Official reference: [LiveView navigation](https://hexdocs.pm/phoenix_live_view/live-navigation.html)

## Examples (13 of 13 bottled)

01. [Stanley sector hop](01-stanley-sector-hop/) — available
02. [Rovaniemi aurora desk](02-rovaniemi-aurora-desk/) — available
03. [Yakutsk frost patches](03-yakutsk-frost-patches/) — available
04. [Iqaluit medevac navigate](04-iqaluit-medevac-navigate/) — available
05. [Phu Quoc stand replace](05-phu-quoc-stand-replace/) — available
06. [Timbuktu dust params](06-timbuktu-dust-params/) — available
07. [Comodoro Saab patch](07-comodoro-saab-patch/) — available
08. [Banjul hold navigate](08-banjul-hold-navigate/) — available
09. [Gelephu QNH query](09-gelephu-qnh-query/) — available
10. [Narsarsuaq parent patch](10-narsarsuaq-parent-patch/) — available
11. [Labuan Bajo Komodo cell](11-labuan-bajo-komodo-cell/) — available
12. [Socotra dead connect](12-socotra-dead-connect/) — available
13. [Rio Grande Fuegian watch](13-rio-grande-fuegian-watch/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | patch/2 that reuses the process and calls handle_params/3 |
| 02 | navigate/2 that mounts a different LiveView |
| 03 | A live_patch link in HEEx |
| 04 | A live_redirect link across boards |
| 05 | replace: true so the watch does not stack history |
| 06 | handle_params/3 after a patch versus after mount |
| 07 | push_patch from an event, not a link |
| 08 | push_navigate from an event |
| 09 | Query params that survive a patch |
| 10 | A back link that is a patch to the parent board |
| 11 | Navigating from a LiveComponent through the parent |
| 12 | The dead render of the destination, then the live connect |
| 13 | Capstone: patch inside a watch, navigate to the relief board |
