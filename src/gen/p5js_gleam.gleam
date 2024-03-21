import gleam/option.{type Option}

pub type P5

pub type SketchConfig(model) {
  SketchConfig(
    init: fn(P5) -> model,
    draw: fn(P5, model) -> Nil,
    on_tick: Option(fn(model) -> model),
    on_key: Option(fn(String, model) -> model),
    on_mouse: Option(fn(Float, Float, model) -> model),
  )
}

@external(javascript, "../p5js_ffi.mjs", "startSketch")
pub fn start_sketch(config: SketchConfig(model)) -> Nil

@external(javascript, "../p5js_ffi.mjs", "createCanvas")
pub fn create_canvas(p: P5, width: Float, height: Float) -> P5

@external(javascript, "../p5js_ffi.mjs", "background")
pub fn background(p: P5, gray_scale: Int) -> P5

@external(javascript, "../p5js_ffi.mjs", "ellipse")
pub fn ellipse(
  p: P5,
  x_center: Float,
  y_center: Float,
  width: Float,
  height: Float,
) -> P5

@external(javascript, "../p5js_ffi.mjs", "circle")
pub fn circle(p: P5, x_center: Float, y_center: Float, radius: Float) -> P5

@external(javascript, "../p5js_ffi.mjs", "rectangle")
pub fn rectangle(
  p: P5,
  top_left_x: Float,
  top_left_y: Float,
  width: Float,
  height: Float,
) -> P5

@external(javascript, "../p5js_ffi.mjs", "square")
pub fn square(
  p: P5,
  top_left_x: Float,
  top_left_y: Float,
  side_length: Float,
) -> P5

@external(javascript, "../p5js_ffi.mjs", "line")
pub fn line(
  p: P5,
  point1_x: Float,
  point1_y: Float,
  point2_x: Float,
  point2_y: Float,
) -> P5

@external(javascript, "../p5js_ffi.mjs", "quad")
pub fn quad(
  p: P5,
  p1_x: Float,
  p1_y: Float,
  p2_x: Float,
  p2_y: Float,
  p3_x: Float,
  p3_y: Float,
  p4_x: Float,
  p4_y: Float,
) -> P5

@external(javascript, "../p5js_ffi.mjs", "fill")
pub fn fill(p: P5, color_hex: String) -> P5

@external(javascript, "../p5js_ffi.mjs", "stroke")
pub fn stroke(p: P5, color_hex: String) -> P5

@external(javascript, "../p5js_ffi.mjs", "strokeWeight")
pub fn stroke_weight(p: P5, weight: Int) -> P5
