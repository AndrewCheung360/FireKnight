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

  let knight_hurt_box = Knight.hurt_box knight in
  let guardian_hurt_box = FrostGuardian.hurt_box guardian in

  if check_collision_recs knight_hurt_box guardian_hurt_box then begin
    let overlap_x =
      min
        (Rectangle.x guardian_hurt_box
        +. Rectangle.width guardian_hurt_box
        -. Rectangle.x knight_hurt_box)
        (Rectangle.x knight_hurt_box
        +. Rectangle.width knight_hurt_box
        -. Rectangle.x guardian_hurt_box)
    in
    let new_knight_x = Vector2.x knight.position +. (overlap_x /. 2.0) in
    knight.position <- Vector2.create new_knight_x (Vector2.y knight.position)
  end;

  if Knight.hit_box knight <> None then begin
    let hit_box = Option.get (Knight.hit_box knight) in
    if check_collision_recs hit_box guardian_hurt_box then begin
      if knight.attack_landed = false then begin
        knight.attack_landed <- true;
        Knight.apply_damage knight guardian
      end
    end
  end;
  begin_drawing ();
  Background.draw_ice_background bg_texture;
  FrostGuardian.draw guardian;
  Knight.draw knight;
  StatusBar.draw statusbar;
  StatusBar.draw_red_healthbar statusbar (knight.health /. 1000.);
  StatusBar.draw_boss_healthbar statusbar (guardian.health /. 10000.);
  end_drawing ();
  loop (music, knight, guardian, statusbar, bg_texture)

let () = setup () |> loop
