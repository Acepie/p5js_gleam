const elements = {
  createCanvas: ["width: Int", "height: Int"],
  background: ["gray_scale: Int"],
  ellipse: ["x_center: Int", "y_center: Int", "width: Int", "height: Int"],
};

const camelToSnakeCase = (str: string) =>
  str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);

const js = (name: string) =>
  `export function ${name}(p, ...args) {
  return p.${name}(...args);
}

`;

const gleam = (name: string, args: string[]) =>
  `@external(javascript, "../p5js_ffi.mjs", "${name}")
pub fn ${camelToSnakeCase(name)}(p: P5${args.length ? ", " : ""}${args.join(
    ", "
  )}) -> Nil

`;

let outGleam = `pub type P5

@external(javascript, "../p5js_ffi.mjs", "startSketch")
pub fn start_sketch(init: fn(P5) -> model, draw: fn(P5, model) -> Nil, on_tick: fn(model) -> model) -> Nil

`;

let outJs = `export const startSketch = (setup, draw, tick) => {
  let model;
  new p5(function (p) {
    p.setup = function () {
      model = setup(p);
    };

    p.draw = function () {
      draw(p, model);
      model = tick(model);
    };
  });
};

`;

for (const element of Object.entries(elements)) {
  outGleam += gleam(element[0], element[1]);
  outJs += js(element[0]);
}

await Promise.all([
  Bun.write("src/gen/p5js_gleam.gleam", outGleam),
  Bun.write("src/p5js_ffi.mjs", outJs),
]);
