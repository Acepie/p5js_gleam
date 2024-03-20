import gen/p5js_gleam.{type P5} as p5

type Ball {
  Ball(x: Int, y: Int, dx: Int, dy: Int)
}

type WorldState {
  WorldState(ball: Ball)
}

const ball_size = 40

const screen_width = 850

const screen_height = 600

const initial_ball = Ball(50, 50, 5, 5)

fn setup(p: P5) -> WorldState {
  p5.create_canvas(p, screen_width, screen_height)
  WorldState(initial_ball)
}

fn draw(p: P5, state: WorldState) -> Nil {
  p5.background(p, 220)
  let Ball(x, y, _, _) = state.ball
  p5.ellipse(p, x, y, ball_size * 2, ball_size * 2)
}

fn advance_ball(b: Ball) -> Ball {
  Ball(b.x + b.dx, b.y + b.dy, b.dx, b.dy)
}

fn flip_ball_x(b: Ball) -> Ball {
  Ball(b.x - b.dx * 2, b.y + b.dy, -b.dx, b.dy)
}

fn flip_ball_y(b: Ball) -> Ball {
  Ball(b.x + b.dx, b.y - b.dy * 2, b.dx, -b.dy)
}

fn tick(state: WorldState) -> WorldState {
  let ball = state.ball
  case ball.x, ball.y {
    x, _ if x < 0 || x > screen_width -> WorldState(flip_ball_x(ball))
    _, y if y < 0 || y > screen_height -> WorldState(flip_ball_y(ball))
    _, _ -> WorldState(advance_ball(ball))
  }
}

pub fn main() {
  p5.start_sketch(setup, draw, tick)
}
