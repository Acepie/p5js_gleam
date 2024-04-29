import p5js_gleam.{type Assets, type P5}
import p5js_gleam/bindings as p5

fn preload(p: P5) -> Assets {
  let loaded_font = p5.load_font(p, "./Lato-Regular.ttf")

  p5js_gleam.initialize_assets()
  |> p5js_gleam.insert_font("Lato", loaded_font)
}

fn setup(p: P5) -> String {
  p5.create_canvas(p, 800.0, 600.0)
  "Hello, world!"
}

fn draw(p: P5, state: String, assets: Assets) {
  p5.background(p, "#ffffff")
  p5.fill(p, "#000000")
  p5.text_size(p, 48)
  p5.text_font_from_string(p, "serif")
  p5.text(p, state, 400.0, 100.0)
  p5.text_font_from_string(p, "Walter Turncoat")
  p5.text(p, state, 400.0, 200.0)
  let assert Ok(font) = p5js_gleam.get_font(assets, "Lato")
  p5.text_font(p, font)
  p5.text(p, state, 400.0, 300.0)
}

pub fn main() {
  p5js_gleam.create_sketch_with_preloading(
    preload: preload,
    init: setup,
    draw: draw,
  )
  |> p5.start_sketch
}
