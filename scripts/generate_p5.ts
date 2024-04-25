const elements = {
  createCanvas: ["width: Float", "height: Float"],
  text: ["text: String", "bottom_corner_x: Float", "bottom_corner_y: Float"],
  textSize: ["size: Int"],
  background: ["color: String"],
  ellipse: [
    "x_center: Float",
    "y_center: Float",
    "width: Float",
    "height: Float",
  ],
  circle: ["x_center: Float", "y_center: Float", "radius: Float"],
  rect: [
    "top_left_x: Float",
    "top_left_y: Float",
    "width: Float",
    "height: Float",
  ],
  square: ["top_left_x: Float", "top_left_y: Float", "side_length: Float"],
  line: [
    "point1_x: Float",
    "point1_y: Float",
    "point2_x: Float",
    "point2_y: Float",
  ],
  quad: [
    "p1_x: Float",
    "p1_y: Float",
    "p2_x: Float",
    "p2_y: Float",
    "p3_x: Float",
    "p3_y: Float",
    "p4_x: Float",
    "p4_y: Float",
  ],
  fill: ["color_hex: String"],
  stroke: ["color_hex: String"],
  noStroke: [],
  strokeWeight: ["weight: Int"],
};

const camelToSnakeCase = (str: string) =>
  str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);

const js = (name: string) =>
  `export function ${name}(p, ...args) {
  p.${name}(...args);
  return p;
}

`;

const gleam = (name: string, args: string[]) =>
  `/// A binding to the p5.js \`${name}\` function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "${name}")
pub fn ${camelToSnakeCase(name)}(p: P5${args.length ? ", " : ""}${args.join(
    ", "
  )}) -> P5

`;

let outGleam = `import p5js_gleam.{type P5, type SketchConfig}

/// Starts a p5.js sketch with the given configuration.
@external(javascript, "../p5js_ffi.mjs", "startSketch")
pub fn start_sketch(config: SketchConfig(model, ignored)) -> Nil

`;

let outJs = `import { is_some, unwrap } from "../gleam_stdlib/gleam/option.mjs";

export const startSketch = (config) => {
  let model;
  new p5(function (p) {
    p.setup = function () {
      model = config.init(p);
    };

    p.draw = function () {
      config.draw(p, model);
      if (is_some(config.on_tick)) {
        model = unwrap(config.on_tick)(model);
      }
    };

    if (is_some(config.on_key_pressed)) {
      p.keyPressed = function () {
        model = unwrap(config.on_key_pressed)(p.key, p.keyCode, model);
      };
    }

    if (is_some(config.on_key_released)) {
      p.keyReleased = function () {
        model = unwrap(config.on_key_released)(p.key, p.keyCode, model);
      };
    }

    if (is_some(config.on_mouse_clicked)) {
      p.mouseClicked = function () {
        model = unwrap(config.on_mouse_clicked)(p.pmouseX, p.pmouseY, model);
      };
    }

    if (is_some(config.on_mouse_moved)) {
      p.mouseMoved = function () {
        model = unwrap(config.on_mouse_moved)(p.pmouseX, p.pmouseY, model);
      };
    }
  });
};

`;

for (const element of Object.entries(elements)) {
  outGleam += gleam(element[0], element[1]);
  outJs += js(element[0]);
}

await Promise.all([
  Bun.write("src/p5js_gleam/bindings.gleam", outGleam),
  Bun.write("src/p5js_ffi.mjs", outJs),
]);
