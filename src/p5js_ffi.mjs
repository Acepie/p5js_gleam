export const startSketch = (setup, draw, tick) => {
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

export function createCanvas(p, ...args) {
  return p.createCanvas(...args);
}

export function background(p, ...args) {
  return p.background(...args);
}

export function ellipse(p, ...args) {
  return p.ellipse(...args);
}

