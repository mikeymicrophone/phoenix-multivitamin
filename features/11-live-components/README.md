# LiveComponents

stateful and stateless LiveComponents, update/2, handle_event in the child, send/2 to the parent, and id that keeps a component alive across renders.

Official reference: [LiveComponents](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveComponent.html)

## Examples (0 of 13 bottled)

01. Kelp dryer trays — planned
02. Buoy depot paint rack — planned
03. Lummi reefnet tally — planned
04. Terminal shed lamps — planned
05. Strait chart locker — planned
06. Seattle traffic board — planned
07. Port Gamble tide staff — planned
08. Coupeville landing slip — planned
09. Samish shellfish ticket — planned
10. Lopez freight bell — planned
11. Goose Point retort tickets — planned
12. La Conner cannery pass — planned
13. Admiralty pilot orders — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A stateful component with its own id |
| 02 | update/2 instead of mount for later assigns |
| 03 | handle_event/3 in the component, not the parent |
| 04 | send/2 from child to parent |
| 05 | send(self(), ...) from parent to a component via update |
| 06 | preload/1 for a batch of components |
| 07 | A stateless component with no id |
| 08 | update_component/3 from the parent |
| 09 | A component nested inside another component |
| 10 | The difference between myself and the parent pid |
| 11 | Assigns the parent owns versus assigns the child owns |
| 12 | A component that survives a parent re-render |
| 13 | Capstone: several components, preload, and a parent that coordinates |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
