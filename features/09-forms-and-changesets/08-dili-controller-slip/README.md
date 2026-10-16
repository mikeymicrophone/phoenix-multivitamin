# Forms and changesets · 08 · Dili controller slip

Clerk Rosa files an IPTN CN-235 through a controller, not a LiveView.

**What it teaches**

- The form posts through a controller.
- A valid slip redirects. An invalid slip re-renders the changeset.

**Files**

| File | Role |
| --- | --- |
| [`cn_slip.ex`](cn_slip.ex) | Destination changeset |
| [`controller_slip_live.ex`](controller_slip_live.ex) | Catalog door to the controller |
| [`controller_slip_controller.ex`](controller_slip_controller.ex) | new, create, show |
| [`controller_slip_html.ex`](controller_slip_html.ex) | Controller form and show |
| [`controller_slip_live_test.exs`](controller_slip_live_test.exs) | Redirect and invalid re-render |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/08-dili-controller-slip](http://localhost:4000/features/09-forms-and-changesets/08-dili-controller-slip).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/08-dili-controller-slip/controller_slip_live_test.exs
```
