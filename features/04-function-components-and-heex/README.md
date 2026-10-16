# Function components and HEEx

attr, slot, embed_templates, declarative assigns, and composing HEEx without a LiveView having to own every tag.

Official reference: [Function components and HEEx](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html)

## Examples (13 of 13 bottled)

01. [Payerne Roadster flight plate](01-payerne-roadster-flight-plate/) — available
02. [São José Embraer tags](02-sao-jose-embraer-tags/) — available
03. [Filton Concorde labels](03-filton-concorde-labels/) — available
04. [Tekapo glider tags](04-tekapo-glider-tags/) — available
05. [Tianjin assembly tickets](05-tianjin-assembly-tickets/) — available
06. [Cranfield SAF sachets](06-cranfield-saf-sachets/) — available
07. [Hahnweide work cards](07-hahnweide-work-cards/) — available
08. [Derby Trent heat slips](08-derby-trent-heat-slips/) — available
09. [Friedrichshafen dope board](09-friedrichshafen-dope-board/) — available
10. [Milford Sound permits](10-milford-sound-permits/) — available
11. [Linköping Gripen trays](11-linkoping-gripen-trays/) — available
12. [Woomera telemetry tags](12-woomera-telemetry-tags/) — available
13. [Longyearbyen polar cards](13-longyearbyen-polar-cards/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | attr with types, defaults, values, and required |
| 02 | Named slots versus inner_block, with slot attrs |
| 03 | embed_templates for a label the HEEx file owns |
| 04 | HEEx :for, :if, :key, and :let |
| 05 | Global attributes and rest |
| 06 | Dynamic attributes and class lists |
| 07 | render_slot/2 with arguments |
| 08 | A component that renders another component |
| 09 | HEEx change tracking: Map.put versus assign |
| 10 | Phoenix.Component helpers: assign_new, update, dynamic_tag, intersperse, to_form, used_input? |
| 11 | values: at compile time versus a dynamic assign |
| 12 | HTML safety: interpolated versus raw versus {:safe, _} |
| 13 | Capstone: attrs, slots, nested cards, rest, and class lists on one polar sheet |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
