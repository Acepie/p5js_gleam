import gleam/dict
import gleam/option.{type Option}

/// A reference to the P5js library. Primarily used to access the P5js APIs for drawing.
pub type P5

/// A reference to a P5js image object. Should be used by passing it to the P5js `image` function.
pub type P5Image

/// A reference to a P5js font object. Should be used by passing it to the P5js `textFont` function.
pub type P5Font

/// Assets that are loaded in `preload` like images and fonts. Can be used later during rendering.
pub opaque type Assets {
  /// Assets that are loaded in `preload`.
  Assets(
    /// Fonts loaded in `preload`
    fonts: dict.Dict(String, P5Font),
    /// Images loaded in `preload`
    images: dict.Dict(String, P5Image),
  )
}

/// Creates an initial empty asset set.
pub fn initialize_assets() -> Assets {
  Assets(dict.new(), dict.new())
}

/// Adds a font to the asset set.
pub fn insert_font(assets: Assets, font_key: String, font: P5Font) -> Assets {
  Assets(..assets, fonts: dict.insert(assets.fonts, font_key, font))
}

/// Adds an image to the asset set.
pub fn insert_image(assets: Assets, image_key: String, image: P5Image) -> Assets {
  Assets(..assets, images: dict.insert(assets.images, image_key, image))
}

/// Get a font from the asset set.
pub fn get_font(assets: Assets, font_key: String) -> Result(P5Font, Nil) {
  dict.get(assets.fonts, font_key)
}

/// Get an image from the asset set.
pub fn get_image(assets: Assets, image_key: String) -> Result(P5Image, Nil) {
  dict.get(assets.images, image_key)
}

/// Configuration to start a sketch. Requires an init function to create the initial model, and a draw function to draw the model. Other handlers can also be provided to update the model based on different user events. Use the `create_sketch` function and the `set_*` helpers to initialize your config.
pub opaque type SketchConfig(model, ignored) {
  BaseConfig(
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
  ConfigWithLoadingAssets(
    /// The preload function takes a reference to the P5js library and returns the assets that can be used by the sketch. This is needed to load external assets such as fonts and images prior to starting the sketch.
    preload: fn(P5) -> Assets,
    /// The init function takes a reference to the P5js library and returns the initial model. It should also create the canvas/do any P5 specific initialization.
    init: fn(P5) -> model,
    /// The draw function takes a reference to the P5js library, any assets loaded during preload, and the current model then renders it to the screen.
    draw: fn(P5, model, Assets) -> ignored,
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
  BaseConfig(
    init,
    draw,
    option.None,
    option.None,
    option.None,
    option.None,
    option.None,
  )
}

/// Creates a sketch configuration that supports preloading assets.
pub fn create_sketch_with_preloading(
  preload preload: fn(P5) -> Assets,
  init init: fn(P5) -> model,
  draw draw: fn(P5, model, Assets) -> ignored,
) -> SketchConfig(model, ignored) {
  ConfigWithLoadingAssets(
    preload,
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
  case s {
    BaseConfig(
      init,
      draw,
      _on_tick,
      on_key_pressed,
      on_key_released,
      on_mouse_moved,
      on_mouse_clicked,
    ) ->
      BaseConfig(
        init,
        draw,
        option.Some(on_tick),
        on_key_pressed,
        on_key_released,
        on_mouse_moved,
        on_mouse_clicked,
      )
    ConfigWithLoadingAssets(
      preload,
      init,
      draw,
      _on_tick,
      on_key_pressed,
      on_key_released,
      on_mouse_moved,
      on_mouse_clicked,
    ) ->
      ConfigWithLoadingAssets(
        preload,
        init,
        draw,
        option.Some(on_tick),
        on_key_pressed,
        on_key_released,
        on_mouse_moved,
        on_mouse_clicked,
      )
  }
}

/// Sets the `on_key_pressed` function to be called.
pub fn set_on_key_pressed(
  s: SketchConfig(model, ignored),
  on_key_pressed: fn(String, Int, model) -> model,
) -> SketchConfig(model, ignored) {
  case s {
    BaseConfig(
      init,
      draw,
      on_tick,
      _on_key_pressed,
      on_key_released,
      on_mouse_moved,
      on_mouse_clicked,
    ) ->
      BaseConfig(
        init,
        draw,
        on_tick,
        option.Some(on_key_pressed),
        on_key_released,
        on_mouse_moved,
        on_mouse_clicked,
      )
    ConfigWithLoadingAssets(
      preload,
      init,
      draw,
      on_tick,
      _on_key_pressed,
      on_key_released,
      on_mouse_moved,
      on_mouse_clicked,
    ) ->
      ConfigWithLoadingAssets(
        preload,
        init,
        draw,
        on_tick,
        option.Some(on_key_pressed),
        on_key_released,
        on_mouse_moved,
        on_mouse_clicked,
      )
  }
}

/// Sets the `on_key_released` function to be called.
pub fn set_on_key_released(
  s: SketchConfig(model, ignored),
  on_key_released: fn(String, Int, model) -> model,
) -> SketchConfig(model, ignored) {
  case s {
    BaseConfig(
      init,
      draw,
      on_tick,
      on_key_pressed,
      _on_key_released,
      on_mouse_moved,
      on_mouse_clicked,
    ) ->
      BaseConfig(
        init,
        draw,
        on_tick,
        on_key_pressed,
        option.Some(on_key_released),
        on_mouse_moved,
        on_mouse_clicked,
      )
    ConfigWithLoadingAssets(
      preload,
      init,
      draw,
      on_tick,
      on_key_pressed,
      _on_key_released,
      on_mouse_moved,
      on_mouse_clicked,
    ) ->
      ConfigWithLoadingAssets(
        preload,
        init,
        draw,
        on_tick,
        on_key_pressed,
        option.Some(on_key_released),
        on_mouse_moved,
        on_mouse_clicked,
      )
  }
}

/// Sets the `on_mouse_moved` function to be called.
pub fn set_on_mouse_moved(
  s: SketchConfig(model, ignored),
  on_mouse_moved: fn(Float, Float, model) -> model,
) -> SketchConfig(model, ignored) {
  case s {
    BaseConfig(
      init,
      draw,
      on_tick,
      on_key_pressed,
      on_key_released,
      _on_mouse_moved,
      on_mouse_clicked,
    ) ->
      BaseConfig(
        init,
        draw,
        on_tick,
        on_key_pressed,
        on_key_released,
        option.Some(on_mouse_moved),
        on_mouse_clicked,
      )
    ConfigWithLoadingAssets(
      preload,
      init,
      draw,
      on_tick,
      on_key_pressed,
      on_key_released,
      _on_mouse_moved,
      on_mouse_clicked,
    ) ->
      ConfigWithLoadingAssets(
        preload,
        init,
        draw,
        on_tick,
        on_key_pressed,
        on_key_released,
        option.Some(on_mouse_moved),
        on_mouse_clicked,
      )
  }
}

/// Sets the `on_mouse_clicked` function to be called.
pub fn set_on_mouse_clicked(
  s: SketchConfig(model, ignored),
  on_mouse_clicked: fn(Float, Float, model) -> model,
) -> SketchConfig(model, ignored) {
  case s {
    BaseConfig(
      init,
      draw,
      on_tick,
      on_key_pressed,
      on_key_released,
      on_mouse_moved,
      _on_mouse_clicked,
    ) ->
      BaseConfig(
        init,
        draw,
        on_tick,
        on_key_pressed,
        on_key_released,
        on_mouse_moved,
        option.Some(on_mouse_clicked),
      )
    ConfigWithLoadingAssets(
      preload,
      init,
      draw,
      on_tick,
      on_key_pressed,
      on_key_released,
      on_mouse_moved,
      _on_mouse_clicked,
    ) ->
      ConfigWithLoadingAssets(
        preload,
        init,
        draw,
        on_tick,
        on_key_pressed,
        on_key_released,
        on_mouse_moved,
        option.Some(on_mouse_clicked),
      )
  }
}
