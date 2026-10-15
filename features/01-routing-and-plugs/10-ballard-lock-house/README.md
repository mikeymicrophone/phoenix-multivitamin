# Routing and plugs · 10 · Ballard lock house

Keeper Soren works the two chambers at the Hiram M. Chittenden Locks, the
Ballard lock house on the Lake Washington Ship Canal. `plug BallardLockPlug,
chambers: 2` runs `init/1` when the controller compiles. That timestamp is
reused on every lockage. `call/2` stamps a fresh time for each request.

**What it teaches**

- `init/1` runs at compile time (when the controller that declares the plug
  is compiled). Its return value is captured.
- `call/2` runs per request and receives that captured map, not the original
  keyword list.
- A timestamp taken in `init/1` is identical across two requests; a
  timestamp taken in `call/2` is not.

**Files**

| File | Role |
| --- | --- |
| [`lock_house_live.ex`](lock_house_live.ex) | Catalog page |
| [`lock_plug.ex`](lock_plug.ex) | init/1 compiled_at versus call/2 called_at |
| [`lock_house_controller.ex`](lock_house_controller.ex) | `plug ..., chambers: 2` |
| [`lock_house_html.ex`](lock_house_html.ex) | The lock house board |
| [`lock_house_test.exs`](lock_house_test.exs) | Same compiled_at, different called_at |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/10-ballard-lock-house](http://localhost:4000/features/01-routing-and-plugs/10-ballard-lock-house).

```sh
mix test features/01-routing-and-plugs/10-ballard-lock-house/lock_house_test.exs
```
