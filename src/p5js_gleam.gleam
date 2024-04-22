import gleam/option.{type Option}

/// A reference to the P5js library. Primarily used to access the P5js APIs for drawing.
pub type P5

/// Configuration to start a sketch. Requires an init function to create the initial model, and a draw function to draw the model. Other handlers can also be provided to update the model based on different user events. Use the `create_sketch` function and the `set_*` helpers to initialize your config.
pub opaque type SketchConfig(model, ignored) {
  SketchConfig(
    /// The init function takes a reference to the P5js library and returns the initial model. It should also create the canvas/do any P5 specific initialization.
    init: fn(P5) -> model,
    /// The draw function takes a reference to the P5js library and the current model then renders it to the screen.
    draw: fn(P5, model) -> ignored,
    /// Called on every frame. on_tick functions take the current model, and return the updated model for the next frame.
    on_tick: Option(fn(model) -> model),
    /// Called whenever a key is pressed down. on_key_pressed functions take a string representing the key that was pressed and a keycode representing the raw key code of the pressed key, and the current model, and return the updated model.
    on_key_pressed: Option(fn(String, Int, model) -> model),
    /// Called whenever a key is released. on_key_released functions take a string representing the key that was pressed and a keycode representing the raw key code of the pressed key, and the current model, and return the updated model.
    on_key_released: Option(fn(String, Int, model) -> model),
    /// Called whenever the user moves their mouse. on_mouse_move functions take the x and y coordinates of the mouse, and the current model, and return the updated model.
    on_mouse_moved: Option(fn(Float, Float, model) -> model),
    /// Called whenever the user clicks their mouse. on_mouse_click functions take the x and y coordinates of the mouse, and the current model, and return the updated model.
    on_mouse_clicked: Option(fn(Float, Float, model) -> model),
  )
}

/// Creates a minimal sketch configuration.
pub fn create_sketch(
  init init: fn(P5) -> model,
  draw draw: fn(P5, model) -> ignored,
) -> SketchConfig(model, ignored) {
  SketchConfig(
    init,
    draw,
    option.None,
    option.None,
    option.None,
    option.None,
    option.None,
  )
}

/// Sets the `on_tick` function to be called.
pub fn set_on_tick(
  s: SketchConfig(model, ignored),
  on_tick: fn(model) -> model,
) -> SketchConfig(model, ignored) {
  SketchConfig(..s, on_tick: option.Some(on_tick))
}

/// Sets the `on_key_pressed` function to be called.
pub fn set_on_key_pressed(
  s: SketchConfig(model, ignored),
  on_key_pressed: fn(String, Int, model) -> model,
) -> SketchConfig(model, ignored) {
  SketchConfig(..s, on_key_pressed: option.Some(on_key_pressed))
}

/// Sets the `on_key_released` function to be called.
pub fn set_on_key_released(
  s: SketchConfig(model, ignored),
  on_key_released: fn(String, Int, model) -> model,
) -> SketchConfig(model, ignored) {
  SketchConfig(..s, on_key_released: option.Some(on_key_released))
}

/// Sets the `on_mouse_moved` function to be called.
pub fn set_on_mouse_moved(
  s: SketchConfig(model, ignored),
  on_mouse_moved: fn(Float, Float, model) -> model,
) -> SketchConfig(model, ignored) {
  SketchConfig(..s, on_mouse_moved: option.Some(on_mouse_moved))
}

/// Sets the `on_mouse_clicked` function to be called.
pub fn set_on_mouse_clicked(
  s: SketchConfig(model, ignored),
  on_mouse_clicked: fn(Float, Float, model) -> model,
) -> SketchConfig(model, ignored) {
  SketchConfig(..s, on_mouse_clicked: option.Some(on_mouse_clicked))
}
