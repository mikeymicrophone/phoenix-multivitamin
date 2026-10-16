# LiveComponents

stateful and stateless LiveComponents, update/2, handle_event in the child, send/2 to the parent, and id that keeps a component alive across renders.

Official reference: [LiveComponents](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveComponent.html)

## Examples (13 of 13 bottled)

01. [Qaanaaq frost cell](01-qaanaaq-frost-cell/) — available
02. [Tobruk update desk](02-tobruk-update-desk/) — available
03. [Berbera event cell](03-berbera-event-cell/) — available
04. [Khorog parent ping](04-khorog-parent-ping/) — available
05. [Coyhaique brief cell](05-coyhaique-brief-cell/) — available
06. [Murmansk batch rack](06-murmansk-batch-rack/) — available
07. [Samos stateless plate](07-samos-stateless-plate/) — available
08. [Karaganda send update](08-karaganda-send-update/) — available
09. [Bumthang nest card](09-bumthang-nest-card/) — available
10. [Rankin Inlet myself](10-rankin-inlet-myself/) — available
11. [Lae assign split](11-lae-assign-split/) — available
12. [Bodø survive cell](12-bodo-survive-cell/) — available
13. [Petropavlovsk capstone rack](13-petropavlovsk-capstone-rack/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A stateful component with its own id |
| 02 | update/2 instead of mount for later assigns |
| 03 | handle_event/3 in the component, not the parent |
| 04 | send/2 from child to parent |
| 05 | send(self(), ...) from parent to a component via update |
| 06 | update_many/1 for a batch of components |
| 07 | A stateless component that still requires an id |
| 08 | send_update/3 from the parent |
| 09 | A component nested inside another component |
| 10 | The difference between myself and the parent pid |
| 11 | Assigns the parent owns versus assigns the child owns |
| 12 | A component that survives a parent re-render |
| 13 | Capstone: several components, update_many, and a parent that coordinates |
