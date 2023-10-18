open Constants
open Raylib
open Knight

let width = Constants.screen_width
let height = Constants.screen_height
let fps = Constants.fps

let setup () =
  init_window width height "Fire Knight";
  set_target_fps fps;
  Knight.create_knight_animation ()

let rec loop knight =
  if window_should_close () then close_window () else Knight.update knight;
  begin_drawing ();
  clear_background Color.raywhite;
  Knight.draw knight;

  end_drawing ();
  loop knight

let () = setup () |> loop
