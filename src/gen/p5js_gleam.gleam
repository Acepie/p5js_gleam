pub type P5

@external(javascript, "../p5js_ffi.mjs", "startSketch")
pub fn start_sketch(
  init: fn(P5) -> model,
  draw: fn(P5, model) -> Nil,
  on_tick: fn(model) -> model,
) -> Nil

@external(javascript, "../p5js_ffi.mjs", "createCanvas")
pub fn create_canvas(p: P5, width: Int, height: Int) -> Nil

@external(javascript, "../p5js_ffi.mjs", "background")
pub fn background(p: P5, gray_scale: Int) -> Nil

@external(javascript, "../p5js_ffi.mjs", "ellipse")
pub fn ellipse(
  p: P5,
  x_center: Int,
  y_center: Int,
  width: Int,
  height: Int,
) -> Nil
