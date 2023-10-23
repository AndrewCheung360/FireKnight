open Fireknight
open Constants
open Raylib
open Knight
open Frostguardian
open Background

let width = Constants.screen_width
let height = Constants.screen_height
let fps = Constants.fps

let setup () =
  init_window width height "Fire Knight";
  set_target_fps fps;
  ( Knight.create_knight_animation (),
    FrostGuardian.create_frostguardian_animation (),
    Background.initialize () )

let rec loop (knight, guardian, bg_texture) =
  if window_should_close () then close_window () else Knight.update knight;
  FrostGuardian.update guardian;
  begin_drawing ();
  Background.draw_ice_background bg_texture;
  Knight.draw knight;
  FrostGuardian.draw guardian;
  end_drawing ();
  loop (knight, guardian, bg_texture)

let () = setup () |> loop
