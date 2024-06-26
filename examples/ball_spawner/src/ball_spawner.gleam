import gleam/float
import gleam/io
import gleam/list
import gleam/string
import p5js_gleam.{type P5}
import p5js_gleam/bindings as p5

type Vector {
  Vector(x: Float, y: Float)
}

fn add_vectors(a: Vector, b: Vector) -> Vector {
  Vector(a.x +. b.x, a.y +. b.y)
}

type Ball {
  Ball(position: Vector, velocity: Vector, color: String)
}

type WorldState {
  WorldState(balls: List(Ball))
}

const background_color = "#2f2f2f"

const colors = ["#ffaff3", "#ffaff3", "#fefefc", "#a6f0fc", "#fffbe8"]

const ball_size = 40.0

const ball_speed = 5.0

const screen_width = 850.0

const screen_height = 600.0

fn setup(p: P5) -> WorldState {
  p5.create_canvas(p, screen_width, screen_height)
  WorldState([])
}

fn draw(p: P5, state: WorldState) {
  p5.background(p, background_color)
  use Ball(Vector(x, y), _, color) <- list.map(state.balls)
  p
  |> p5.fill(color)
  |> p5.ellipse(x, y, ball_size *. 2.0, ball_size *. 2.0)
}

fn advance_ball(b: Ball) -> Ball {
  Ball(add_vectors(b.position, b.velocity), b.velocity, b.color)
}

fn flip_ball_x(b: Ball) -> Ball {
  let Ball(position, velocity, color) = b
  let new_velocity = Vector(float.negate(velocity.x), velocity.y)
  let new_position =
    Vector(position.x -. velocity.x *. 2.0, position.y +. velocity.y)
  Ball(new_position, new_velocity, color)
}

fn flip_ball_y(b: Ball) -> Ball {
  let Ball(position, velocity, color) = b
  let new_velocity = Vector(velocity.x, float.negate(velocity.y))
  let new_position =
    Vector(position.x +. velocity.x, position.y -. velocity.y *. 2.0)
  Ball(new_position, new_velocity, color)
}

fn tick(state: WorldState) -> WorldState {
  let balls = {
    use ball <- list.map(state.balls)
    let Ball(Vector(x, y), _, _) = ball
    case x, y {
      x, _ if x <. 0.0 || x >. screen_width -> flip_ball_x(ball)
      _, y if y <. 0.0 || y >. screen_height -> flip_ball_y(ball)
      _, _ -> advance_ball(ball)
    }
  }
  WorldState(balls)
}

fn on_key_pressed(key: String, key_code: Int, state: WorldState) -> WorldState {
  io.debug(
    "On key pressed called with key: "
    <> key
    <> ", keyCode: "
    <> string.inspect(key_code)
    <> ", and current state: "
    <> string.inspect(state),
  )
  state
}

fn on_key_released(key: String, key_code: Int, state: WorldState) -> WorldState {
  io.debug(
    "On key released called with key: "
    <> key
    <> ", keyCode: "
    <> string.inspect(key_code)
    <> ", and current state: "
    <> string.inspect(state),
  )
  state
}

fn on_mouse_moved(
  x_position: Float,
  y_position: Float,
  state: WorldState,
) -> WorldState {
  io.debug(
    "On mouse moved called with x position: "
    <> string.inspect(x_position)
    <> ", y position: "
    <> string.inspect(y_position)
    <> ", and current state: "
    <> string.inspect(state),
  )
  state
}

fn on_mouse_clicked(
  x_position: Float,
  y_position: Float,
  state: WorldState,
) -> WorldState {
  let assert [color, ..] =
    colors
    |> list.shuffle()
  let x_speed = case float.random() {
    x if x <. 0.5 -> ball_speed
    _ -> float.negate(ball_speed)
  }
  let y_speed = case float.random() {
    x if x <. 0.5 -> ball_speed
    _ -> float.negate(ball_speed)
  }
  WorldState([
    Ball(Vector(x_position, y_position), Vector(x_speed, y_speed), color),
    ..state.balls
  ])
}

pub fn main() {
  p5js_gleam.create_sketch(init: setup, draw: draw)
  |> p5js_gleam.set_on_tick(tick)
  |> p5js_gleam.set_on_key_pressed(on_key_pressed)
  |> p5js_gleam.set_on_key_released(on_key_released)
  |> p5js_gleam.set_on_mouse_moved(on_mouse_moved)
  |> p5js_gleam.set_on_mouse_clicked(on_mouse_clicked)
  |> p5.start_sketch
}
