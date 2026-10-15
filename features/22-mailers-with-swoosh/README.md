# Mailers with Swoosh

Swoosh.Email, deliver, the local adapter, mailbox preview, and a mailer that sends a watch brief rather than a generic notice.

Official reference: [Mailers with Swoosh](https://hexdocs.pm/swoosh/Swoosh.html)

## Examples (0 of 13 bottled)

01. Watch brief mailer — planned
02. Retort cook complete mailer — planned
03. Berth assignment mailer — planned
04. Fog signal outage mailer — planned
05. Lens cabinet inventory mailer — planned
06. Chart correction mailer — planned
07. Hatchery release mailer — planned
08. Seed press proof mailer — planned
09. Lockage delay mailer — planned
10. Pilot boarding mailer — planned
11. Net loft ready mailer — planned
12. Buoy paint cure mailer — planned
13. Overnight handover mailer — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | new/0, to/2, from/2, subject/2, text_body/2 |
| 02 | html_body/2 next to the text body |
| 03 | deliver/1 through the application mailer |
| 04 | The Local adapter and /dev/mailbox |
| 05 | The Test adapter in mix test |
| 06 | An attachment on the cook card |
| 07 | A layout for HTML mail |
| 08 | Assigns in a mailer HEEx template |
| 09 | deliver_later versus deliver now |
| 10 | A failed delivery and the error tuple |
| 11 | Verified routes inside the body |
| 12 | From an address that is a station, not noreply@ |
| 13 | Capstone: text, html, attachment, and a mailbox preview |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
