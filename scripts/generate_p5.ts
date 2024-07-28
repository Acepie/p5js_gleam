interface Argument {
  label: string;
  type: string;
}

function argumentToString(argument: Argument) {
  return `${argument.label} ${argument.label}: ${argument.type}`;
}

interface FunctionBinding {
  arguments: Argument[];
  returnType?: string; // defaults to P5
  bindingName?: string; // if not provided, the name of the function will be used
}

const functions: Record<string, FunctionBinding> = {
  createCanvas: {
    arguments: [
      {
        label: "width",
        type: "Float",
      },
      {
        label: "height",
        type: "Float",
      },
    ],
  },
  text: {
    arguments: [
      {
        label: "text",
        type: "String",
      },
      {
        label: "bottom_corner_x",
        type: "Float",
      },
      {
        label: "bottom_corner_y",
        type: "Float",
      },
    ],
  },
  textAlign: {
    arguments: [
      {
        label: "horizontal",
        type: "String",
      },
      {
        label: "vertical",
        type: "String",
      },
    ],
  },
  textFont: {
    arguments: [
      {
        label: "font",
        type: "P5Font",
      },
    ],
  },
  textFontFromString: {
    arguments: [
      {
        label: "font",
        type: "String",
      },
    ],
    bindingName: "textFont",
  },
  textSize: {
    arguments: [
      {
        label: "size",
        type: "Int",
      },
    ],
  },
  textWidth: {
    arguments: [
      {
        label: "text",
        type: "String",
      },
    ],
    returnType: "Float",
  },
  background: {
    arguments: [
      {
        label: "color",
        type: "String",
      },
    ],
  },
  ellipse: {
    arguments: [
      {
        label: "x_center",
        type: "Float",
      },
      {
        label: "y_center",
        type: "Float",
      },
      {
        label: "width",
        type: "Float",
      },
      {
        label: "height",
        type: "Float",
      },
    ],
  },
  circle: {
    arguments: [
      {
        label: "x_center",
        type: "Float",
      },
      {
        label: "y_center",
        type: "Float",
      },
      {
        label: "diameter",
        type: "Float",
      },
    ],
  },
  rect: {
    arguments: [
      {
        label: "top_left_x",
        type: "Float",
      },
      {
        label: "top_left_y",
        type: "Float",
      },
      {
        label: "width",
        type: "Float",
      },
      {
        label: "height",
        type: "Float",
      },
    ],
  },
  triangle: {
    arguments: [
      {
        label: "point1_x",
        type: "Float",
      },
      {
        label: "point1_y",
        type: "Float",
      },
      {
        label: "point2_x",
        type: "Float",
      },
      {
        label: "point2_y",
        type: "Float",
      },
      {
        label: "point3_x",
        type: "Float",
      },
      {
        label: "point3_y",
        type: "Float",
      },
    ],
  },
  square: {
    arguments: [
      {
        label: "top_left_x",
        type: "Float",
      },
      {
        label: "top_left_y",
        type: "Float",
      },
      {
        label: "side_length",
        type: "Float",
      },
    ],
  },
  line: {
    arguments: [
      {
        label: "point1_x",
        type: "Float",
      },
      {
        label: "point1_y",
        type: "Float",
      },
      {
        label: "point2_x",
        type: "Float",
      },
      {
        label: "point2_y",
        type: "Float",
      },
    ],
  },
  quad: {
    arguments: [
      { label: "point1_x", type: "Float" },
      { label: "point1_y", type: "Float" },
      { label: "point2_x", type: "Float" },
      { label: "point2_y", type: "Float" },
      { label: "point3_x", type: "Float" },
      { label: "point3_y", type: "Float" },
      { label: "point4_x", type: "Float" },
      { label: "point4_y", type: "Float" },
    ],
  },
  image: {
    arguments: [
      { label: "image", type: "P5Image" },
      { label: "top_left_x", type: "Float" },
      { label: "top_left_y", type: "Float" },
      { label: "width", type: "Float" },
      { label: "height", type: "Float" },
    ],
  },
  fill: { arguments: [{ label: "color_hex", type: "String" }] },
  noFill: { arguments: [] },
  stroke: { arguments: [{ label: "color_hex", type: "String" }] },
  noStroke: { arguments: [] },
  strokeWeight: { arguments: [{ label: "weight", type: "Int" }] },
  erase: {
    arguments: [
      { label: "strength", type: "Int" },
      { label: "edge_strength", type: "Int" },
    ],
  },
  noErase: { arguments: [] },
  loadImage: {
    arguments: [{ label: "path", type: "String" }],
    returnType: "P5Image",
  },
  loadFont: {
    arguments: [{ label: "path", type: "String" }],
    returnType: "P5Font",
  },
};

interface ConstantBinding {
  value?: any; // if not provided, the name of the constant will be used
  type?: string; // defaults to string
  bindingName?: string; // if not provided, the name of the constant will be used
}

const constants: Record<string, ConstantBinding> = {
  right: {},
  left: {},
  center: {},
  top: {},
  bottom: {},
  baseline: {
    value: "alphabetic",
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

const gleam = (name: string, binding: FunctionBinding) =>
  `/// A binding to the p5.js [\`${
    binding.bindingName ?? name
  }\`](https://p5js.org/reference/p5/${
    binding.bindingName ?? name
  }) function. Takes a p5 instance and the function's arguments and returns the p5 instance.
@external(javascript, "../p5js_ffi.mjs", "${name}")
pub fn ${camelToSnakeCase(name)}(sketch_instance p: P5${
    binding.arguments.length ? ", " : ""
  }${binding.arguments.map((a) => argumentToString(a)).join(", ")}) -> ${
    binding.returnType ?? "P5"
  }

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

for (const [elementName, elementBinding] of Object.entries(functions)) {
  outGleam += gleam(elementName, elementBinding);
  outJs += js(
    elementName,
    elementBinding.bindingName ?? elementName,
    Boolean(elementBinding.returnType)
  );
}

for (const [constantName, constantBinding] of Object.entries(constants)) {
  outGleam += `pub const ${constantBinding.bindingName ?? constantName} = "${
    constantBinding.value ?? constantName
  }"\n\n`;
}

await Promise.all([
  Bun.write("src/p5js_gleam/bindings.gleam", outGleam),
  Bun.write("src/p5js_ffi.mjs", outJs),
]);
