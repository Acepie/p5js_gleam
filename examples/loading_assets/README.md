# loading_assets

Example rendering a hello message to the screen with 3 different fonts loaded in 3 different ways. The first example uses a system default font requiring no loading. The second example uses a font loaded onto the page via an html link tag. The third example uses a font loaded in the preload function.

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
