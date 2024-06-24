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
  return p.createCanvas(...args);
}

export function text(...args) {
  return p.text(...args);
}

export function textFont(...args) {
  return p.textFont(...args);
}

export function textFontFromString(...args) {
  return p.textFont(...args);
}

export function textSize(...args) {
  return p.textSize(...args);
}

export function textWidth(...args) {
  return p.textWidth(...args);
}

export function background(...args) {
  return p.background(...args);
}

export function ellipse(...args) {
  return p.ellipse(...args);
}

export function circle(...args) {
  return p.circle(...args);
}

export function rect(...args) {
  return p.rect(...args);
}

export function square(...args) {
  return p.square(...args);
}

export function line(...args) {
  return p.line(...args);
}

export function quad(...args) {
  return p.quad(...args);
}

export function image(...args) {
  return p.image(...args);
}

export function fill(...args) {
  return p.fill(...args);
}

export function noFill(...args) {
  return p.noFill(...args);
}

export function stroke(...args) {
  return p.stroke(...args);
}

export function noStroke(...args) {
  return p.noStroke(...args);
}

export function strokeWeight(...args) {
  return p.strokeWeight(...args);
}

export function erase(...args) {
  return p.erase(...args);
}

export function noErase(...args) {
  return p.noErase(...args);
}

export function loadImage(...args) {
  return p.loadImage(...args);
}

export function loadFont(...args) {
  return p.loadFont(...args);
}
