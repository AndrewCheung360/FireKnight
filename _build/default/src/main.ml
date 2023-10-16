open Constants
open Raylib
let width = Constants.screen_width
let height = Constants.screen_height
let fps = Constants.fps
let atlas = load_texture("../assets/characters/Fire_Knight/Fire_Knight_SpriteSheet.png")


let setup () =
  Raylib.init_window width height "Fire Knight";
  Raylib.set_target_fps fps

  

let rec loop () =
  if Raylib.window_should_close () then Raylib.close_window ()
  else
    let open Raylib in
    begin_drawing ();
    clear_background Color.raywhite;
    draw_texture atlas 0 0 Color.raywhite;
    end_drawing ();
    loop ()

let () = setup () |> loop