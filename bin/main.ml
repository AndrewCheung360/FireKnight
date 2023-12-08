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

let reset () =
  init_audio_device ();
  let music = load_music_stream "assets/audio/background_music.mp3" in

  play_music_stream music;
  set_target_fps fps;
  ( music,
    Knight.create_knight_animation (),
    FrostGuardian.create_frostguardian_animation (),
    StatusBar.create_statusbar (),
    Background.initialize (),
    Constants.Playing )

let setup () =
  init_window width height "Fire Knight";
  reset ()

let rec loop (music, knight, guardian, statusbar, bg_texture, game_state) =
  if window_should_close () then begin
    unload_music_stream music;
    close_audio_device ();
    close_window ()
  end
  else
    match game_state with
    | Constants.Playing ->
        update_music_stream music;
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
          knight.position <-
            Vector2.create new_knight_x (Vector2.y knight.position)
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
        if FrostGuardian.hit_box guardian <> None then begin
          let hit_box = Option.get (FrostGuardian.hit_box guardian) in
          if check_collision_recs hit_box knight_hurt_box then begin
            if guardian.attack_landed = false then begin
              guardian.attack_landed <- true;
              knight.hurt <- true;
              knight.health <- knight.health -. 200.
            end
          end
        end;
        begin_drawing ();
        Background.draw_ice_background bg_texture;
        FrostGuardian.draw guardian;
        Knight.draw knight;
        StatusBar.draw statusbar;
        StatusBar.draw_blue_manabar statusbar (knight.mana /. 1000.);
        StatusBar.draw_red_healthbar statusbar (knight.health /. 1000.);
        StatusBar.draw_boss_healthbar statusbar (guardian.health /. 10000.);
        StatusBar.draw_gold knight.gold;
        end_drawing ();
        if
          guardian.state = States.GuardianStates.Death
          && FrostGuardian.is_animation_finished guardian
        then loop (music, knight, guardian, statusbar, bg_texture, Constants.Win)
        else if
          knight.state = States.KnightStates.Death
          && Knight.is_animation_finished knight
        then
          loop
            (music, knight, guardian, statusbar, bg_texture, Constants.GameOver)
        else loop (music, knight, guardian, statusbar, bg_texture, game_state)
    | _ ->
        begin_drawing ();
        StatusBar.draw_restart_screen statusbar knight.gold;
        end_drawing ();
        if is_key_pressed Key.R then begin
          unload_music_stream music;
          close_audio_device ();
          restart ()
        end
        else loop (music, knight, guardian, statusbar, bg_texture, game_state)

and restart () =
  let music, knight, guardian, statusbar, bg_texture, _ = reset () in
  loop (music, knight, guardian, statusbar, bg_texture, Constants.Playing)

let () = setup () |> loop
