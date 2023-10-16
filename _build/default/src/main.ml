open Constants
open Raylib
open Color
let width = Constants.screen_width
let height = Constants.screen_height
let fps = Constants.fps



let setup () =
  init_window width height "Fire Knight";
  set_target_fps fps;
  let tex_knight = load_texture("assets/characters/Fire_Knight/Fire_Knight_SpriteSheet.png") in

  tex_knight
  

let rec loop tex_knight =
  if window_should_close () then close_window ()
  else
    begin_drawing ();
    clear_background raywhite;
    draw_texture tex_knight 0 0 raywhite;
    end_drawing ();
    loop tex_knight

let () = setup () |> loop