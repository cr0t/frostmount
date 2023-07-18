# Frostmount Phoenix Workshop

It's a playground application made for the Elixir Brainwashing workshop.

This app's main goal is to teach students about the Phoenix framework and LiveView and PubSub systems, which are important features of Phoenix.

## How to Work With This Repository

We assume that students have Elixir on their machines. We recommend using [`asdf`](https://asdf-vm.com/) and its [Elixir plugin](https://github.com/asdf-vm/asdf-elixir); check the corresponding links for more information.

Likewise, we split the work step-by-step into a few branches. If you like, you can go through all of them sequentially, or jump to any of the most interesting ones and maybe create a new branch with your own experiments.

Brief summary of the branches/steps:

* [`step-0-overview`](https://github.com/cr0t/frostmount/tree/step-0-overview) contains a bare Phoenix application, as it was just created (without Ecto and Mailer dependencies), it can be used to give an overview of the directories structure
* [`step-1-live-view-basics`](https://github.com/cr0t/frostmount/tree/step-1-live-view-basics) adds an extremely basic LiveView example (`Counter`) just to demo how it works over Websocket and give basic understanding of maintaining the state and handling events
* [`step-2-pre-lobby-form`](https://github.com/cr0t/frostmount/tree/step-2-pre-lobby-form) provides a basis for students to work on the implementation of an interactive form (there are data models, validation logic, and blank template of the Lobby module in place)
* [`step-3-final-lobby-form`](https://github.com/cr0t/frostmount/tree/step-3-final-lobby-form) reveals the final version of the Lobby module (maybe not ideal, but enough for our needs)
* [`step-4-pre-battlefield`](https://github.com/cr0t/frostmount/tree/step-4-pre-battlefield) contains the foundation for the multiplayer game module that is aimed at showing students how to deal with the integrated PubSub functionality and how to send the messages between multiple LiveView processes
* [`step-5-final-battlefield`](https://github.com/cr0t/frostmount/tree/step-5-final-battlefield) the final version of the `Battlefield` module, ready to be run on one machine with multiple browser sessions connected
* [`step-6-deploy-to-fly`](https://github.com/cr0t/frostmount/tree/step-6-deploy-to-fly) shows how to use Fly.io (check the commit messages) to deploy the Frostmount application there, so it can be used by multiple users from different parts of the world
* [`step-extra-pubsub-via-redis`](https://github.com/cr0t/frostmount/tree/step-extra-pubsub-via-redis) contains an experiment – configuration for Redis PubSub adapter – that can allow students to run their Frostmount instances on own machines (in Dev-mode) and let these machines talk to each other as in cluster

## Phoenix Basics

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

### Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
