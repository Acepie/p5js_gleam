# ball_spawner

Simple example of using the library to create a ball spawner. Balls are spawned on click at the clicked location with a random direction and color.

## Bundling the app

This example uses [esgleam](https://hexdocs.pm/esgleam/) to bundle the main gleam module for use in a static site.

To install esbuild run the following command. You should only need to run it once.

```bash
gleam run -m esgleam/install
```

To bundle the app run the following command after making code changes.

```bash
gleam run -m esgleam/bundle
```

## Serving the app

You can use any static site server to host the app but for development you can continue to use esgleam by running

```bash
gleam run -m esgleam/serve
```
