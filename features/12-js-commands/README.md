# JS commands

Phoenix.LiveView.JS push, toggle, show, hide, transition, and composing commands in HEEx without a hook.

Official reference: [JS commands](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.JS.html)

## Examples (13 of 13 bottled)

01. [Qaarsut frost toggle](01-qaarsut-frost-toggle/) — available
02. [Saint-Pierre ticket hide](02-saint-pierre-ticket-hide/) — available
03. [Kutaisi lamp fade](03-kutaisi-lamp-fade/) — available
04. [Gyumri brief push](04-gyumri-brief-push/) — available
05. [Mary class desk](05-mary-class-desk/) — available
06. [Bukhara fog flag](06-bukhara-fog-flag/) — available
07. [Sinop focus pad](07-sinop-focus-pad/) — available
08. [Trabzon dispatch bell](08-trabzon-dispatch-bell/) — available
09. [Bitola target lamp](09-bitola-target-lamp/) — available
10. [Tulcea pipe board](10-tulcea-pipe-board/) — available
11. [Ittoqqortoormiit ignore](11-ittoqqortoormiit-ignore/) — available
12. [Grytviken exec brief](12-grytviken-exec-brief/) — available
13. [Barentsburg capstone board](13-barentsburg-capstone-board/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | JS.toggle/1 on a drawer |
| 02 | JS.show/1 and JS.hide/1 on a ticket |
| 03 | JS.transition/1 for a lamp that fades |
| 04 | JS.push/1 combined with a client command |
| 05 | JS.add_class/1 and JS.remove_class/1 |
| 06 | JS.set_attribute/1 on a fog flag |
| 07 | JS.focus/1 and JS.focus_first/1 |
| 08 | JS.dispatch/1 of a custom event |
| 09 | to: targeting a different element |
| 10 | Composing commands with the pipe |
| 11 | JS.ignore_attributes/1 during a patch |
| 12 | exec from a server-pushed command |
| 13 | Capstone: toggle, push, and a transition on one board |
