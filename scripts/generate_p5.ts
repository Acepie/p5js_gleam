interface Binding {
  arguments: string[];
  returnType?: string; // defaults to P5
  bindingName?: string; // if not provided, the name of the function will be used
}

const elements: Record<string, Binding> = {
  createCanvas: { arguments: ["width: Float", "height: Float"] },
  text: {
    arguments: [
      "text: String",
      "bottom_corner_x: Float",
      "bottom_corner_y: Float",
    ],
  },
  textFont: { arguments: ["font: P5Font"] },
  textFontFromString: { arguments: ["font: String"], bindingName: "textFont" },
  textSize: { arguments: ["size: Int"] },
  textWidth: { arguments: ["text: String"], returnType: "Float" },
  background: { arguments: ["color: String"] },
  ellipse: {
    arguments: [
      "x_center: Float",
      "y_center: Float",
      "width: Float",
      "height: Float",
    ],
  },
  circle: {
    arguments: ["x_center: Float", "y_center: Float", "diameter: Float"],
  },
  rect: {
    arguments: [
      "top_left_x: Float",
      "top_left_y: Float",
      "width: Float",
      "height: Float",
    ],
  },
  square: {
    arguments: ["top_left_x: Float", "top_left_y: Float", "side_length: Float"],
  },
  line: {
    arguments: [
      "point1_x: Float",
      "point1_y: Float",
      "point2_x: Float",
      "point2_y: Float",
    ],
  },
  quad: {
    arguments: [
      "p1_x: Float",
      "p1_y: Float",
      "p2_x: Float",
      "p2_y: Float",
      "p3_x: Float",
      "p3_y: Float",
      "p4_x: Float",
      "p4_y: Float",
    ],
  },
  image: {
    arguments: [
      "image: P5Image",
      "top_left_x: Float",
      "top_left_y: Float",
      "width: Float",
      "height: Float",
    ],
  },
  fill: { arguments: ["color_hex: String"] },
  noFill: { arguments: [] },
  stroke: { arguments: ["color_hex: String"] },
  noStroke: { arguments: [] },
  strokeWeight: { arguments: ["weight: Int"] },
  erase: { arguments: ["strength: Int", "edge_strength: Int"] },
  noErase: { arguments: [] },
  loadImage: {
    arguments: ["path: String"],
    returnType: "P5Image",
  },
  loadFont: {
    arguments: ["path: String"],
    returnType: "P5Font",
  },
};

const camelToSnakeCase = (str: string) =>
  str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);

const jsReturningP5 = (name: string) => `
  p.${name}(...args);
  return p;`;
const jsReturningOriginal = (name: string) => `
  return p.${name}(...args);`;

const js = (name: string, bindingName: string, isReturningOriginal: boolean) =>
  `export function ${name}(p, ...args) {${
    isReturningOriginal
      ? jsReturningOriginal(bindingName)
      : jsReturningP5(bindingName)
  }
}

`;

const gleam = (name: string, binding: Binding) =>
  `/// A binding to the p5.js [\`${
    binding.bindingName ?? name
  }\`](https://p5js.org/reference/#/p5/${
    binding.bindingName ?? name
  }) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "${name}")
pub fn ${camelToSnakeCase(name)}(p: P5${
    binding.arguments.length ? ", " : ""
  }${binding.arguments.join(", ")}) -> ${binding.returnType ?? "P5"}

`;

let outGleam = `import p5js_gleam.{type P5, type P5Image, type P5Font, type SketchConfig}

/// Starts a p5.js sketch with the given configuration.
@external(javascript, "../p5js_ffi.mjs", "startSketch")
pub fn start_sketch(config: SketchConfig(model, ignored)) -> Nil

`;

let outJs = `import { is_some, unwrap } from "../gleam_stdlib/gleam/option.mjs";

export const startSketch = (config) => {
  let model;
  let assets;
  new p5(function (p) {
    if (config.preload) {
      p.preload = function () {
        assets = config.preload(p);
      };
    }

    p.setup = function () {
      model = config.init(p);
    };

    p.draw = function () {
      config.draw(p, model, assets);
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

for (const [elementName, elementBinding] of Object.entries(elements)) {
  outGleam += gleam(elementName, elementBinding);
  outJs += js(
    elementName,
    elementBinding.bindingName ?? elementName,
    Boolean(elementBinding.returnType)
  );
}

await Promise.all([
  Bun.write("src/p5js_gleam/bindings.gleam", outGleam),
  Bun.write("src/p5js_ffi.mjs", outJs),
]);
