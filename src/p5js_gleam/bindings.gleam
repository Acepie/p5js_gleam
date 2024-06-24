import p5js_gleam.{type P5Font, type P5Image, type SketchConfig}

/// Starts a Nil.js sketch with the given configuration.
@external(javascript, "../Niljs_ffi.mjs", "startSketch")
pub fn start_sketch(config: SketchConfig(model, ignored)) -> Nil

/// A binding to the Nil.js [`createCanvas`](https://Niljs.org/reference/#/Nil/createCanvas) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "createCanvas")
pub fn create_canvas(width: Float, height: Float) -> Nil

/// A binding to the Nil.js [`text`](https://Niljs.org/reference/#/Nil/text) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "text")
pub fn text(
  p: Nil,
  text: String,
  bottom_corner_x: Float,
  bottom_corner_y: Float,
) -> Nil

/// A binding to the Nil.js [`textFont`](https://Niljs.org/reference/#/Nil/textFont) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "textFont")
pub fn text_font(font: P5Font) -> Nil

/// A binding to the Nil.js [`textFont`](https://Niljs.org/reference/#/Nil/textFont) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "textFontFromString")
pub fn text_font_from_string(font: String) -> Nil

/// A binding to the Nil.js [`textSize`](https://Niljs.org/reference/#/Nil/textSize) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "textSize")
pub fn text_size(size: Int) -> Nil

/// A binding to the Nil.js [`textWidth`](https://Niljs.org/reference/#/Nil/textWidth) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "textWidth")
pub fn text_width(text: String) -> Float

/// A binding to the Nil.js [`background`](https://Niljs.org/reference/#/Nil/background) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "background")
pub fn background(color: String) -> Nil

/// A binding to the Nil.js [`ellipse`](https://Niljs.org/reference/#/Nil/ellipse) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "ellipse")
pub fn ellipse(
  x_center: Float,
  y_center: Float,
  width: Float,
  height: Float,
) -> Nil

/// A binding to the Nil.js [`circle`](https://Niljs.org/reference/#/Nil/circle) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "circle")
pub fn circle(x_center: Float, y_center: Float, diameter: Float) -> Nil

/// A binding to the Nil.js [`rect`](https://Niljs.org/reference/#/Nil/rect) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "rect")
pub fn rect(
  top_left_x: Float,
  top_left_y: Float,
  width: Float,
  height: Float,
) -> Nil

/// A binding to the Nil.js [`square`](https://Niljs.org/reference/#/Nil/square) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "square")
pub fn square(
  top_left_x: Float,
  top_left_y: Float,
  side_length: Float,
) -> Nil

/// A binding to the Nil.js [`line`](https://Niljs.org/reference/#/Nil/line) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "line")
pub fn line(
  point1_x: Float,
  point1_y: Float,
  point2_x: Float,
  point2_y: Float,
) -> Nil

/// A binding to the Nil.js [`quad`](https://Niljs.org/reference/#/Nil/quad) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "quad")
pub fn quad(
  p1_x: Float,
  p1_y: Float,
  p2_x: Float,
  p2_y: Float,
  p3_x: Float,
  p3_y: Float,
  p4_x: Float,
  p4_y: Float,
) -> Nil

/// A binding to the Nil.js [`image`](https://Niljs.org/reference/#/Nil/image) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "image")
pub fn image(
  image: P5Image,
  top_left_x: Float,
  top_left_y: Float,
  width: Float,
  height: Float,
) -> Nil

/// A binding to the Nil.js [`fill`](https://Niljs.org/reference/#/Nil/fill) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "fill")
pub fn fill(color_hex: String) -> Nil

/// A binding to the Nil.js [`noFill`](https://Niljs.org/reference/#/Nil/noFill) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "noFill")
pub fn no_fill() -> Nil

/// A binding to the Nil.js [`stroke`](https://Niljs.org/reference/#/Nil/stroke) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "stroke")
pub fn stroke(color_hex: String) -> Nil

/// A binding to the Nil.js [`noStroke`](https://Niljs.org/reference/#/Nil/noStroke) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "noStroke")
pub fn no_stroke() -> Nil

/// A binding to the Nil.js [`strokeWeight`](https://Niljs.org/reference/#/Nil/strokeWeight) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "strokeWeight")
pub fn stroke_weight(weight: Int) -> Nil

/// A binding to the Nil.js [`erase`](https://Niljs.org/reference/#/Nil/erase) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "erase")
pub fn erase(strength: Int, edge_strength: Int) -> Nil

/// A binding to the Nil.js [`noErase`](https://Niljs.org/reference/#/Nil/noErase) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "noErase")
pub fn no_erase() -> Nil

/// A binding to the Nil.js [`loadImage`](https://Niljs.org/reference/#/Nil/loadImage) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "loadImage")
pub fn load_image(path: String) -> P5Image

/// A binding to the Nil.js [`loadFont`](https://Niljs.org/reference/#/Nil/loadFont) function. Takes a Nil instance and the function's arguments and returns the Nil instance.
@external(javascript, "../Niljs_ffi.mjs", "loadFont")
pub fn load_font(path: String) -> P5Font
