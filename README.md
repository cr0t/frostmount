# Frostmount Phoenix Workshop

It's a playground application made for the Elixir Brainwashing workshop.

This app's main goal is to teach students about the Phoenix framework and LiveView and PubSub systems, which are important features of Phoenix.

The final result is a multiplayer realtime micro-game that allows group of minions fight against a frozen zombie monster:

<table>
  <tr>
    <td><img width="612" alt="image" src="https://github.com/cr0t/frostmount/assets/113878/f6d3edc1-7775-4fa7-be46-7ef073521e07"></td>
    <td><img width="612" alt="image" src="https://github.com/cr0t/frostmount/assets/113878/3e736802-d77e-413c-83c1-d6744320d3d0"></td>
    <td><img width="612" alt="image" src="https://github.com/cr0t/frostmount/assets/113878/a2a56859-5f29-4870-b8fb-676a8a4f4a8e"></td>
  </tr>
</table>

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
* [`step-extra-deploy-as-container`](https://github.com/cr0t/frostmount/tree/step-extra-deploy-as-container) contains an experiment – scripts for building a container and notes on deployment.

## How to Deploy (as a Container)

### Short Version

Essentially, these are the steps we need to take to deploy this app:

0. Make some changes; bump the app's version in the `mix.exs`.
1. Build a new version image and likely upload it somewhere (e.g., to Docker Hub or GitHub Container Registry).
2. Set up the server machine: we need a reverse proxy (e.g., nginx or traefik) and Docker runtime available there.
3. Use Docker or (maybe easier) Docker Compose to set up and run the app.

### More Detailed One

Foremost, we need to have Docker ready to build images on your development or CI machine (you can have Docker Desktop installed or something else; even Podman may work; just ensure that you have an alias of `podman` to `docker` commands).

We provide two scripts to build and push the image to a registry. Please check the code and comments in the `scripts/build.sh` and `scripts/release.sh` files.

Technically, we only need to execute the `scripts/release.sh <repository/to/be/used/for/image>` command to build a new image and then upload it to the given registry. That's about the first part of the deployment process—making a new image.

There is another side to the deployment: server configuration. It's difficult to recommend any specific way of configuring the public machine on how to handle this. However, for example, we use Nginx as a reverse proxy that listens to some publicly available address (and handles SSL traffic), while the application itself is running in a container on the same (or another) machine as Nginx and handles requests by some internally available port.

We can't provide a detailed Nginx configuration. Though, for the container part, we can recommend using our `docker-compose.example.yml` file in the root of this repository. Just ensure that you point your Docker service to the right registry and set the correct version of the app to be pulled and executed.
