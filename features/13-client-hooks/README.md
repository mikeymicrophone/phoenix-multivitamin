# Client hooks

phx-hook, mounted/updated/destroyed/destroyed callbacks, this.pushEvent, and this.handleEvent for JavaScript that must own a DOM node.

Official reference: [Client hooks](https://hexdocs.pm/phoenix_live_view/js-interop.html)

## Examples (0 of 13 bottled)

01. Cebu Mactan clock hook — planned
02. Jakarta Halim needle hook — planned
03. Denpasar Nusa chime hook — planned
04. Yogyakarta Borobudur canvas — planned
05. Kuching hornbill ruler — planned
06. Penang George Town crank — planned
07. Langkawi cable bells — planned
08. Vientiane Mekong gauges — planned
09. Luang Prabang Pak Ou knobs — planned
10. Taipei Songshan stylus — planned
11. Kaohsiung Love River scope — planned
12. Busan Gwangalli waterfall — planned
13. Kansai Izumisano aligner — planned

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
