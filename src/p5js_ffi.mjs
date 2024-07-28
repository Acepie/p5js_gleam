import { is_some, unwrap } from "../gleam_stdlib/gleam/option.mjs";

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

export function createCanvas(p, ...args) {
  p.createCanvas(...args);
  return p;
}

export function text(p, ...args) {
  p.text(...args);
  return p;
}

export function textAlign(p, ...args) {
  p.textAlign(...args);
  return p;
}

export function textFont(p, ...args) {
  p.textFont(...args);
  return p;
}

export function textFontFromString(p, ...args) {
  p.textFont(...args);
  return p;
}

export function textSize(p, ...args) {
  p.textSize(...args);
  return p;
}

export function textWidth(p, ...args) {
  return p.textWidth(...args);
}

export function background(p, ...args) {
  p.background(...args);
  return p;
}

export function ellipse(p, ...args) {
  p.ellipse(...args);
  return p;
}

export function circle(p, ...args) {
  p.circle(...args);
  return p;
}

export function rect(p, ...args) {
  p.rect(...args);
  return p;
}

export function triangle(p, ...args) {
  p.triangle(...args);
  return p;
}

export function square(p, ...args) {
  p.square(...args);
  return p;
}

export function line(p, ...args) {
  p.line(...args);
  return p;
}

export function quad(p, ...args) {
  p.quad(...args);
  return p;
}

export function image(p, ...args) {
  p.image(...args);
  return p;
}

export function fill(p, ...args) {
  p.fill(...args);
  return p;
}

export function noFill(p, ...args) {
  p.noFill(...args);
  return p;
}

export function stroke(p, ...args) {
  p.stroke(...args);
  return p;
}

export function noStroke(p, ...args) {
  p.noStroke(...args);
  return p;
}

export function strokeWeight(p, ...args) {
  p.strokeWeight(...args);
  return p;
}

export function erase(p, ...args) {
  p.erase(...args);
  return p;
}

export function noErase(p, ...args) {
  p.noErase(...args);
  return p;
}

export function loadImage(p, ...args) {
  return p.loadImage(...args);
}

export function loadFont(p, ...args) {
  return p.loadFont(...args);
}

