import { is_some, unwrap } from "../gleam_stdlib/gleam/option.mjs";

let p = null

export const startSketch = (config) => {
  let model;
  let assets;
  new p5(function (p_) {
    p = p_

    if (config.preload) {
      p.preload = function () {
        assets = config.preload();
      };
    }

    p.setup = function () {
      model = config.init();
    };

    p.draw = function () {
      config.draw(model, assets);
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

export function createCanvas(...args) {
  p.createCanvas(...args);
}

export function text(...args) {
  p.text(...args);
}

export function textFont(...args) {
  p.textFont(...args);
}

export function textFontFromString(...args) {
  p.textFont(...args);
}

export function textSize(...args) {
  p.textSize(...args);
}

export function textWidth(...args) {
  return p.textWidth(...args);
}

export function background(...args) {
  p.background(...args);
}

export function ellipse(...args) {
  p.ellipse(...args);
}

export function circle(...args) {
  p.circle(...args);
}

export function rect(...args) {
  p.rect(...args);
}

export function square(...args) {
  p.square(...args);
}

export function line(...args) {
  p.line(...args);
}

export function quad(...args) {
  p.quad(...args);
}

export function image(...args) {
  p.image(...args);
}

export function fill(...args) {
  p.fill(...args);
}

export function noFill(...args) {
  p.noFill(...args);
}

export function stroke(...args) {
  p.stroke(...args);
}

export function noStroke(...args) {
  p.noStroke(...args);
}

export function strokeWeight(...args) {
  p.strokeWeight(...args);
}

export function erase(...args) {
  p.erase(...args);
}

export function noErase(...args) {
  p.noErase(...args);
}

export function loadImage(...args) {
  return p.loadImage(...args);
}

export function loadFont(...args) {
  return p.loadFont(...args);
}
