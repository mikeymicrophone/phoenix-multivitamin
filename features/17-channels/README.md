# Channels

Phoenix.Channel join, handle_in, handle_out, intercept, and a socket that is not a LiveView.

Official reference: [Channels](https://hexdocs.pm/phoenix/channels.html)

## Examples (0 of 13 bottled)

01. Waadah error wire — planned
02. Partridge Point watch talk — planned
03. Sekiu pilot orders — planned
04. Ozette callback gap — planned
05. Westport retort queue — planned
06. Hansville isolation — planned
07. Cape Disappointment report desk — planned
08. Deception Pass talkback — planned
09. Tatoosh radio room — planned
10. Destruction Island channel — planned
11. Ediz Hook talkback — planned
12. Slip Point join desk — planned
13. Admiralty Inlet channel floor — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | UserSocket connect/3 with a token |
| 02 | join/3 authorizing the station topic |
| 03 | handle_in/3 for a client push |
| 04 | broadcast/3 from the channel |
| 05 | handle_out/3 intercepting a broadcast |
| 06 | reply/2 versus push/3 versus broadcast |
| 07 | Presence tracked from the channel |
| 08 | A channel that assigns the keeper on join |
| 09 | terminate/2 on leave |
| 10 | Topic patterns with a splat |
| 11 | Transport: websocket versus longpoll |
| 12 | Testing a channel with ChannelCase |
| 13 | Capstone: join, in, out, and a second client on the topic |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
