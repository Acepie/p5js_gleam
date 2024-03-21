import gleam/option.{type Option}

/// A reference to the P5js library. Primarily used to access the P5js APIs for drawing.
pub type P5

/// Configuration to start a sketch. Requires an init function to create the initial model, and a draw function to draw the model. Optionally, you can provide an on_tick function to update the model on each frame, an on_key function to handle key events, and an on_mouse function to handle mouse events.
pub type SketchConfig(model) {
  SketchConfig(
    /// The init function takes a reference to the P5js library and returns the initial model. It should also create the canvas/do any P5 specific initialization.
    init: fn(P5) -> model,
    /// The draw function takes a reference to the P5js library and the current model then renders it to the screen.
    draw: fn(P5, model) -> Nil,
    /// on_tick functions take the current model, and return the updated model for the next frame.
    on_tick: Option(fn(model) -> model),
    /// on_key functions take a string representing the key that was pressed, and the current model, and return the updated model.
    on_key: Option(fn(String, model) -> model),
    /// on_mouse functions take the x and y coordinates of the mouse, and the current model, and return the updated model.
    on_mouse: Option(fn(Float, Float, model) -> model),
  )
}
