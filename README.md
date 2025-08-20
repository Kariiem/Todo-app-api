# TodoApi

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix

## Implemented endpoints
- [x] `POST /api/todos`       -> todo_controller:create
- [x] `GET /api/todos`        -> todo_contoller:index
- [x] `GET /api/todos/:id`    -> todo_contoller:show
- [x] `PUT /api/todos/:id`    -> todo_contoller:edit
- [x] `DELETE /api/todos/:id` -> todo_contoller:delete
