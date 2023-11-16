open Fireknight
open Constants
open Raylib
open Knight
open Frostguardian
open Statusbar
open Background

let width = Constants.screen_width
let height = Constants.screen_height
let fps = Constants.fps

let setup () =
  init_window width height "Fire Knight";
  init_audio_device ();
  let music = load_music_stream "assets/audio/background_music.mp3" in

  play_music_stream music;
  set_target_fps fps;
  ( music,
    Knight.create_knight_animation (),
    FrostGuardian.create_frostguardian_animation (),
    StatusBar.create_statusbar (),
    Background.initialize () )

let rec loop (music, knight, guardian, statusbar, bg_texture) =
  if window_should_close () then begin
    unload_music_stream music;
    close_audio_device ();
    close_window ()
  end
  else update_music_stream music;
  Knight.update knight;
  FrostGuardian.update guardian;
  begin_drawing ();
  Background.draw_ice_background bg_texture;
  FrostGuardian.draw guardian;
  Knight.draw knight;
  StatusBar.draw statusbar;
  end_drawing ();
  loop (music, knight, guardian, statusbar, bg_texture)

let () = setup () |> loop
