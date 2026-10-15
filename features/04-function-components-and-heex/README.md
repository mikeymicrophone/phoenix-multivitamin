# Function components and HEEx

attr, slot, embed_templates, declarative assigns, and composing HEEx without a LiveView having to own every tag.

Official reference: [Function components and HEEx](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html)

## Examples (13 of 13 bottled)

01. [Seed packet label press](01-seed-packet-label-press/) — available
02. [Totten Inlet nursery tags](02-totten-inlet-nursery-tags/) — available
03. [Chimacum cider labels](03-chimacum-cider-labels/) — available
04. [Dungeness crab pot tags](04-dungeness-crab-pot-tags/) — available
05. [Port Angeles mill tickets](05-port-angeles-mill-tickets/) — available
06. [Sequim lavender sachets](06-sequim-lavender-sachets/) — available
07. [Port Hadlock boat shop cards](07-port-hadlock-boat-shop-cards/) — available
08. [Irondale foundry heat slips](08-irondale-foundry-heat-slips/) — available
09. [Discovery Bay tile board](09-discovery-bay-tile-board/) — available
10. [Kaleetan trail permits](10-kaleetan-trail-permits/) — available
11. [Elwha hatchery trays](11-elwha-hatchery-trays/) — available
12. [Hoko River smolt tags](12-hoko-river-smolt-tags/) — available
13. [Skokomish weir cards](13-skokomish-weir-cards/) — available

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
| 13 | Capstone: attrs, slots, nested cards, rest, and class lists on one weir sheet |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
