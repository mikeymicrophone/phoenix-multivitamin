# Client hooks

phx-hook, mounted/updated/destroyed/destroyed callbacks, this.pushEvent, and this.handleEvent for JavaScript that must own a DOM node.

Official reference: [Client hooks](https://hexdocs.pm/phoenix_live_view/js-interop.html)

## Examples (0 of 13 bottled)

01. Lighthouse watch clock — planned
02. Tide staff reading needle — planned
03. Bell buoy ledger chime — planned
04. Wharf office chalk canvas — planned
05. Cap Sante net loft ruler — planned
06. Dosewallips tide gate crank — planned
07. Coupled fog bells — planned
08. Anacortes cannery retort gauges — planned
09. Ferry sailing filter knobs — planned
10. Keeper watch slate stylus — planned
11. Fog signal oscilloscope — planned
12. Hydrophone waterfall — planned
13. Range light aligner — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | mounted/1 on a canvas the server does not draw |
| 02 | updated/1 when assigns change under the hook |
| 03 | destroyed/1 tearing down a listener |
| 04 | this.pushEvent/3 from the hook to the LiveView |
| 05 | this.handleEvent/2 from the LiveView to the hook |
| 06 | this.pushEventTo/4 targeting a component |
| 07 | A hook that reads dataset attributes |
| 08 | reconnected/1 after a dropped socket |
| 09 | A hook on a stream row |
| 10 | js-interop with a third-party widget |
| 11 | Preventing a hook from running on the static render |
| 12 | colocate the hook next to the scenario, not in app.js copy |
| 13 | Capstone: mount, push, handle, and destroy on one instrument |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
