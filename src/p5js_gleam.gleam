import gen/p5js_gleam.{type P5} as p5

type Ball {
  Ball(x: Int, y: Int, dx: Int, dy: Int)
}

type WorldState {
  WorldState(ball: Ball)
}

const screen_size = 400

const initial_ball = Ball(50, 50, 5, 5)

fn setup(p: P5) -> WorldState {
  p5.create_canvas(p, screen_size, screen_size)
  WorldState(initial_ball)
}

fn draw(p: P5, state: WorldState) -> Nil {
  p5.background(p, 220)

  let Ball(x, y, _, _) = state.ball
  p5.ellipse(p, x, y, 80, 80)
}

fn tick(state: WorldState) -> WorldState {
  let ball = state.ball
  let new_ball = Ball(ball.x + ball.dx, ball.y + ball.dy, ball.dx, ball.dy)
  WorldState(new_ball)
}

pub fn main() {
  p5.start_sketch(setup, draw, tick)
}
