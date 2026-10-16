# Client hooks

Phoenix LiveView hook lifecycle callbacks, `this.pushEvent` replies,
`this.pushEventTo` component targeting, and `push_event/3` with
`this.handleEvent` for JavaScript that owns a DOM node. Each hook is colocated
in its scenario's HEEx, using the existing `colocatedHooks` registry in
`assets/js/app.js`; no external scripts or new dependencies are needed.

Official reference: [Client hooks](https://hexdocs.pm/phoenix_live_view/js-interop.html)

## Examples (13 of 13 bottled)

01. [Cebu Mactan clock hook](01-cebu-mactan-clock-hook/) — available
02. [Jakarta Halim needle hook](02-jakarta-halim-needle-hook/) — available
03. [Denpasar Nusa chime hook](03-denpasar-nusa-chime-hook/) — available
04. [Yogyakarta Borobudur canvas](04-yogyakarta-borobudur-canvas/) — available
05. [Kuching hornbill ruler](05-kuching-hornbill-ruler/) — available
06. [Penang George Town crank](06-penang-george-town-crank/) — available
07. [Langkawi cable bells](07-langkawi-cable-bells/) — available
08. [Vientiane Mekong gauges](08-vientiane-mekong-gauges/) — available
09. [Luang Prabang Pak Ou knobs](09-luang-prabang-pak-ou-knobs/) — available
10. [Taipei Songshan stylus](10-taipei-songshan-stylus/) — available
11. [Kaohsiung Love River scope](11-kaohsiung-love-river-scope/) — available
12. [Busan Gwangalli waterfall](12-busan-gwangalli-waterfall/) — available
13. [Kansai Izumisano aligner](13-kansai-izumisano-aligner/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | Two dataset time zones, mounted clocks, and destroyed interval cleanup |
| 02 | beforeUpdate/updated, an ignored canvas, and guarded bearing parsing |
| 03 | Window dispatch listener removal when a bell is packed away |
| 04 | Nested pointer payloads, with validation, and pushEvent callback replies |
| 05 | Server-pushed ruler ticks and handleEvent subscription cleanup |
| 06 | pushEventTo selectors targeting independent LiveComponents |
| 07 | Tuple programs, dataset updates, and replacing a cadence interval |
| 08 | disconnected/reconnected, a mounted handshake, and authoritative snapshots |
| 09 | Per-row hooks, custom stream IDs, update-only inserts, and parameter-driven deletion |
| 10 | Native stylus widget, ResizeObserver, AbortController, and a bounded reduce_while |
| 11 | Static fallback, connected-only hook markup, and an arming handshake |
| 12 | Colocated hook reuse in a component with global attributes, named slots, and :let |
| 13 | Enforced-key struct, String.Chars, sequence guards, replies, pushes, and teardown |

## Ownership and verification

Every hook has a unique DOM ID and `phx-update="ignore"`: JavaScript owns
its children. Server state lives outside those roots or travels through
merged `data-*` attributes and pushed events. Stream rows retain stable IDs.
The colocated compiler scopes `.HookName` to its defining module and bundles
it through the existing LiveSocket hook registry.

Run the feature scaffolding with:

```sh
mix test features/13-client-hooks
mix precommit
```

LiveViewTest checks hook markup, server handlers, replies, and pushed payloads.
It does not execute JavaScript or simulate browser lifecycle callbacks. In a
browser, try packing/unpacking the Denpasar bell, parking a Pak Ou row,
resizing the Songshan pad, and stowing/redeploying the Kansai instrument.
For Vientiane, use `window.liveSocket.disconnect()` and
`window.liveSocket.connect()` in the console to exercise reconnect recovery.
No browser behavior is recorded as a discovery until verified.
