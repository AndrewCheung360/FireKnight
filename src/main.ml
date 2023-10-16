open Constants
open Raylib
open Color
let width = Constants.screen_width
let height = Constants.screen_height
let fps = Constants.fps
let position = ref (Vector2.create 0. (-500.))
let src_rect = Rectangle.create 100. 83. 60. 44.
let dest_rect = Rectangle.create 0. 0. 240. 176.
let vel = Constants.move_vel

let setup () =
  init_window width height "Fire Knight";
  set_target_fps fps;

  let knight_spritesheet = load_texture("assets/characters/Fire_Knight/Fire_Knight_SpriteSheet.png") in

  knight_spritesheet
  
  let handle_input () =
    if is_key_down Key.Right then
      position := Vector2.add !position (Vector2.create (-.vel) 0.0)
    else if is_key_down Key.Left then
      position := Vector2.add !position (Vector2.create vel 0.0)

let rec loop knight_spritesheet =
  if window_should_close () then close_window ()
  else
    handle_input ();
    begin_drawing ();
    clear_background raywhite;
    draw_texture_pro knight_spritesheet src_rect dest_rect !position 0. raywhite;
    end_drawing ();
    loop knight_spritesheet

let () = setup () |> loop