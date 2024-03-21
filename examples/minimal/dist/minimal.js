// build/dev/javascript/prelude.mjs
var CustomType = class {
  withFields(fields) {
    let properties = Object.keys(this).map(
      (label) => label in fields ? fields[label] : this[label]
    );
    return new this.constructor(...properties);
  }
};
function isEqual(x, y) {
  let values = [x, y];
  while (values.length) {
    let a = values.pop();
    let b = values.pop();
    if (a === b)
      continue;
    if (!isObject(a) || !isObject(b))
      return false;
    let unequal = !structurallyCompatibleObjects(a, b) || unequalDates(a, b) || unequalBuffers(a, b) || unequalArrays(a, b) || unequalMaps(a, b) || unequalSets(a, b) || unequalRegExps(a, b);
    if (unequal)
      return false;
    const proto = Object.getPrototypeOf(a);
    if (proto !== null && typeof proto.equals === "function") {
      try {
        if (a.equals(b))
          continue;
        else
          return false;
      } catch {
      }
    }
    let [keys, get] = getters(a);
    for (let k of keys(a)) {
      values.push(get(a, k), get(b, k));
    }
  }
  return true;
}
function getters(object) {
  if (object instanceof Map) {
    return [(x) => x.keys(), (x, y) => x.get(y)];
  } else {
    let extra = object instanceof globalThis.Error ? ["message"] : [];
    return [(x) => [...extra, ...Object.keys(x)], (x, y) => x[y]];
  }
}
function unequalDates(a, b) {
  return a instanceof Date && (a > b || a < b);
}
function unequalBuffers(a, b) {
  return a.buffer instanceof ArrayBuffer && a.BYTES_PER_ELEMENT && !(a.byteLength === b.byteLength && a.every((n, i) => n === b[i]));
}
function unequalArrays(a, b) {
  return Array.isArray(a) && a.length !== b.length;
}
function unequalMaps(a, b) {
  return a instanceof Map && a.size !== b.size;
}
function unequalSets(a, b) {
  return a instanceof Set && (a.size != b.size || [...a].some((e) => !b.has(e)));
}
function unequalRegExps(a, b) {
  return a instanceof RegExp && (a.source !== b.source || a.flags !== b.flags);
}
function isObject(a) {
  return typeof a === "object" && a !== null;
}
function structurallyCompatibleObjects(a, b) {
  if (typeof a !== "object" && typeof b !== "object" && (!a || !b))
    return false;
  let nonstructural = [Promise, WeakSet, WeakMap, Function];
  if (nonstructural.some((c) => a instanceof c))
    return false;
  return a.constructor === b.constructor;
}

// build/dev/javascript/gleam_stdlib/gleam/option.mjs
var Some = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var None = class extends CustomType {
};
function is_some(option) {
  return !isEqual(option, new None());
}
function unwrap(option, default$) {
  if (option instanceof Some) {
    let x = option[0];
    return x;
  } else {
    return default$;
  }
}

// build/dev/javascript/p5js_gleam/p5js_gleam.mjs
var SketchConfig = class extends CustomType {
  constructor(init, draw2, on_tick, on_key, on_mouse) {
    super();
    this.init = init;
    this.draw = draw2;
    this.on_tick = on_tick;
    this.on_key = on_key;
    this.on_mouse = on_mouse;
  }
};

// build/dev/javascript/p5js_gleam/p5js_ffi.mjs
var startSketch = (config) => {
  let model;
  new p5(function(p) {
    p.setup = function() {
      model = config.init(p);
    };
    p.draw = function() {
      config.draw(p, model);
      if (is_some(config.on_tick)) {
        model = unwrap(config.on_tick)(model);
      }
    };
    if (is_some(config.on_key)) {
      p.keyPressed = function() {
        model = unwrap(config.on_key)(p.key, model);
      };
    }
    if (is_some(config.on_mouse)) {
      p.mouseClicked = function() {
        model = unwrap(config.on_mouse)(p.pmouseX, p.pmouseY, model);
      };
    }
  });
};
function createCanvas(p, ...args) {
  p.createCanvas(...args);
  return p;
}
function text(p, ...args) {
  p.text(...args);
  return p;
}
function background(p, ...args) {
  p.background(...args);
  return p;
}
function fill(p, ...args) {
  p.fill(...args);
  return p;
}

// build/dev/javascript/minimal/minimal.mjs
function setup(p) {
  createCanvas(p, 800, 600);
  return "Hello, world!";
}
function draw(p, state) {
  background(p, "#ffffff");
  fill(p, "#000000");
  text(p, state, 400, 300);
  return void 0;
}
function main() {
  return startSketch(
    new SketchConfig(
      setup,
      draw,
      new None(),
      new None(),
      new None()
    )
  );
}
export {
  main
};
