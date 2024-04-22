import p5js_gleam.{type P5}
import p5js_gleam/bindings as p5

fn setup(p: P5) -> String {
  p5.create_canvas(p, 800.0, 600.0)
  "Hello, world!"
}

fn draw(p: P5, state: String) {
  p5.background(p, "#ffffff")
  p5.fill(p, "#000000")
  p5.text(p, state, 400.0, 300.0)
}

pub fn main() {
  p5js_gleam.create_sketch(init: setup, draw: draw)
  |> p5.start_sketch
}
