import gen/p5js_gleam.{type P5, SketchConfig} as p5
import gleam/option
import gleam/float
import gleam/io
import gleam/list

type Ball {
  Ball(x: Float, y: Float, dx: Float, dy: Float)
}

type WorldState {
  WorldState(balls: List(Ball))
}

const ball_size = 40.0

const ball_speed = 5.0

const screen_width = 850.0

const screen_height = 600.0

fn setup(p: P5) -> WorldState {
  p5.create_canvas(p, screen_width, screen_height)
  WorldState([])
}

fn draw(p: P5, state: WorldState) -> Nil {
  p5.background(p, 220)
  {
    use Ball(x, y, _, _) <- list.map(state.balls)
    p5.ellipse(p, x, y, ball_size *. 2.0, ball_size *. 2.0)
  }
  Nil
}

fn advance_ball(b: Ball) -> Ball {
  Ball(b.x +. b.dx, b.y +. b.dy, b.dx, b.dy)
}

fn flip_ball_x(b: Ball) -> Ball {
  Ball(b.x -. b.dx *. 2.0, b.y +. b.dy, float.negate(b.dx), b.dy)
}

fn flip_ball_y(b: Ball) -> Ball {
  Ball(b.x +. b.dx, b.y -. b.dy *. 2.0, b.dx, float.negate(b.dy))
}

fn tick(state: WorldState) -> WorldState {
  io.debug(state)
  let balls = {
    use ball <- list.map(state.balls)
    case ball.x, ball.y {
      x, _ if x <. 0.0 || x >. screen_width -> flip_ball_x(ball)
      _, y if y <. 0.0 || y >. screen_height -> flip_ball_y(ball)
      _, _ -> advance_ball(ball)
    }
  }

  WorldState(balls)
}

fn on_key(key: String, state: WorldState) -> WorldState {
  io.println(key)
  state
}

fn on_mouse(
  x_position: Float,
  y_position: Float,
  state: WorldState,
) -> WorldState {
  io.debug(x_position)
  io.debug(y_position)
  state
  WorldState([
    Ball(x_position, y_position, ball_speed, ball_speed),
    ..state.balls
  ])
}

pub fn main() {
  p5.start_sketch(SketchConfig(
    init: setup,
    draw: draw,
    on_tick: option.Some(tick),
    on_key: option.Some(on_key),
    on_mouse: option.Some(on_mouse),
  ))
}
