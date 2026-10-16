# LiveComponents

stateful and stateless LiveComponents, update/2, handle_event in the child, send/2 to the parent, and id that keeps a component alive across renders.

Official reference: [LiveComponents](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveComponent.html)

## Examples (0 of 13 bottled)

01. Recife fuel cell — planned
02. Brasília Planalto component — planned
03. Foz do Iguaçu falls card — planned
04. Windhoek Hosea Kutako cell — planned
05. Cape Town Table component — planned
06. Casablanca Anfa card — planned
07. Tunis Carthage cell — planned
08. Cairo Sphinx component — planned
09. Kigali Virunga card — planned
10. Dar es Salaam Nyerere cell — planned
11. Antananarivo baobab card — planned
12. Mauritius SSR component — planned
13. Mahé Seychelles cell — planned

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
