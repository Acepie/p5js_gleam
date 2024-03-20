# p5js_gleam

A demo showcasing how to create and use bindings for [p5js](https://p5js.org/)

This project is made up of

- A [bun](https://bun.sh/) script that is used to generate bindings for p5js class methods
- An html page that shows how to use those bindings to make a basic animation

## Generating FFI Bindings

To generate the FFI bindings you will need bun installed. Once you have bun installed run

```bash
bun run ./scripts/generate_p5.ts
```

### Bundling the app

This example uses [esgleam](https://hexdocs.pm/esgleam/) to bundle the main gleam module for use in a static site. To bundle the app run

```bash
gleam run -m esgleam/bundle
```

### Serving the app

You can use any static site server to host the app but for development you can continue to use esgleam by running

```bash
gleam run -m esgleam/serve
```
