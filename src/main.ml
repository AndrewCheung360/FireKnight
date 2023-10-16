open Constants
let width = Constants.width
let height = Constants.height
let setup () =
  Raylib.init_window width height "Fire Knight";
  Raylib.set_target_fps 60

let rec loop () =
  if Raylib.window_should_close () then Raylib.close_window ()
  else
    let open Raylib in
    begin_drawing ();
    clear_background Color.raywhite;
    end_drawing ();
    loop ()

let () = setup () |> loop