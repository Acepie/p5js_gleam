import p5js_gleam.{type P5, type P5Font, type P5Image, type SketchConfig}

/// Starts a p5.js sketch with the given configuration.
@external(javascript, "../p5js_ffi.mjs", "startSketch")
pub fn start_sketch(config: SketchConfig(model, ignored)) -> Nil

/// A binding to the p5.js [`createCanvas`](https://p5js.org/reference/p5/createCanvas) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "createCanvas")
pub fn create_canvas(
  sketch_instance p: P5,
  width width: Float,
  height height: Float,
) -> P5

/// A binding to the p5.js [`text`](https://p5js.org/reference/p5/text) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "text")
pub fn text(
  sketch_instance p: P5,
  text text: String,
  bottom_corner_x bottom_corner_x: Float,
  bottom_corner_y bottom_corner_y: Float,
) -> P5

/// A binding to the p5.js [`textAlign`](https://p5js.org/reference/p5/textAlign) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "textAlign")
pub fn text_align(
  sketch_instance p: P5,
  horizontal horizontal: String,
  vertical vertical: String,
) -> P5

/// A binding to the p5.js [`textFont`](https://p5js.org/reference/p5/textFont) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "textFont")
pub fn text_font(sketch_instance p: P5, font font: P5Font) -> P5

/// A binding to the p5.js [`textFont`](https://p5js.org/reference/p5/textFont) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "textFontFromString")
pub fn text_font_from_string(sketch_instance p: P5, font font: String) -> P5

/// A binding to the p5.js [`textSize`](https://p5js.org/reference/p5/textSize) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "textSize")
pub fn text_size(sketch_instance p: P5, size size: Int) -> P5

/// A binding to the p5.js [`textWidth`](https://p5js.org/reference/p5/textWidth) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "textWidth")
pub fn text_width(sketch_instance p: P5, text text: String) -> Float

/// A binding to the p5.js [`background`](https://p5js.org/reference/p5/background) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "background")
pub fn background(sketch_instance p: P5, color color: String) -> P5

/// A binding to the p5.js [`ellipse`](https://p5js.org/reference/p5/ellipse) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "ellipse")
pub fn ellipse(
  sketch_instance p: P5,
  x_center x_center: Float,
  y_center y_center: Float,
  width width: Float,
  height height: Float,
) -> P5

/// A binding to the p5.js [`circle`](https://p5js.org/reference/p5/circle) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "circle")
pub fn circle(
  sketch_instance p: P5,
  x_center x_center: Float,
  y_center y_center: Float,
  diameter diameter: Float,
) -> P5

/// A binding to the p5.js [`rect`](https://p5js.org/reference/p5/rect) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "rect")
pub fn rect(
  sketch_instance p: P5,
  top_left_x top_left_x: Float,
  top_left_y top_left_y: Float,
  width width: Float,
  height height: Float,
) -> P5

/// A binding to the p5.js [`triangle`](https://p5js.org/reference/p5/triangle) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "triangle")
pub fn triangle(
  sketch_instance p: P5,
  point1_x point1_x: Float,
  point1_y point1_y: Float,
  point2_x point2_x: Float,
  point2_y point2_y: Float,
  point3_x point3_x: Float,
  point3_y point3_y: Float,
) -> P5

/// A binding to the p5.js [`square`](https://p5js.org/reference/p5/square) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "square")
pub fn square(
  sketch_instance p: P5,
  top_left_x top_left_x: Float,
  top_left_y top_left_y: Float,
  side_length side_length: Float,
) -> P5

/// A binding to the p5.js [`line`](https://p5js.org/reference/p5/line) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "line")
pub fn line(
  sketch_instance p: P5,
  point1_x point1_x: Float,
  point1_y point1_y: Float,
  point2_x point2_x: Float,
  point2_y point2_y: Float,
) -> P5

/// A binding to the p5.js [`quad`](https://p5js.org/reference/p5/quad) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "quad")
pub fn quad(
  sketch_instance p: P5,
  point1_x point1_x: Float,
  point1_y point1_y: Float,
  point2_x point2_x: Float,
  point2_y point2_y: Float,
  point3_x point3_x: Float,
  point3_y point3_y: Float,
  point4_x point4_x: Float,
  point4_y point4_y: Float,
) -> P5

/// A binding to the p5.js [`image`](https://p5js.org/reference/p5/image) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "image")
pub fn image(
  sketch_instance p: P5,
  image image: P5Image,
  top_left_x top_left_x: Float,
  top_left_y top_left_y: Float,
  width width: Float,
  height height: Float,
) -> P5

/// A binding to the p5.js [`fill`](https://p5js.org/reference/p5/fill) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "fill")
pub fn fill(sketch_instance p: P5, color_hex color_hex: String) -> P5

/// A binding to the p5.js [`noFill`](https://p5js.org/reference/p5/noFill) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "noFill")
pub fn no_fill(sketch_instance p: P5) -> P5

/// A binding to the p5.js [`stroke`](https://p5js.org/reference/p5/stroke) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "stroke")
pub fn stroke(sketch_instance p: P5, color_hex color_hex: String) -> P5

/// A binding to the p5.js [`noStroke`](https://p5js.org/reference/p5/noStroke) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "noStroke")
pub fn no_stroke(sketch_instance p: P5) -> P5

/// A binding to the p5.js [`strokeWeight`](https://p5js.org/reference/p5/strokeWeight) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "strokeWeight")
pub fn stroke_weight(sketch_instance p: P5, weight weight: Int) -> P5

/// A binding to the p5.js [`erase`](https://p5js.org/reference/p5/erase) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "erase")
pub fn erase(
  sketch_instance p: P5,
  strength strength: Int,
  edge_strength edge_strength: Int,
) -> P5

/// A binding to the p5.js [`noErase`](https://p5js.org/reference/p5/noErase) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "noErase")
pub fn no_erase(sketch_instance p: P5) -> P5

/// A binding to the p5.js [`loadImage`](https://p5js.org/reference/p5/loadImage) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "loadImage")
pub fn load_image(sketch_instance p: P5, path path: String) -> P5Image

/// A binding to the p5.js [`loadFont`](https://p5js.org/reference/p5/loadFont) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "loadFont")
pub fn load_font(sketch_instance p: P5, path path: String) -> P5Font

pub const right = "right"

pub const left = "left"

pub const center = "center"

pub const top = "top"

pub const bottom = "bottom"

pub const baseline = "alphabetic"
