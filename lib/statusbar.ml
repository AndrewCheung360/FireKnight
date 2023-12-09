module StatusBar = struct
  open Raylib
  open Frames.HudFrames
  open Sprites

  type t = {
    sprite_sheet : Texture.t;
    health : int;
    mana : int;
    portrait : Texture.t;
    frames : Sprite.t;
  }

  let create_statusbar () =
    let hud_spritesheet = load_texture "assets/HUD/GUI.png" in
    let status_bar_frames = Hashtbl.create 10 in
    Hashtbl.add status_bar_frames "healthbar" healthbar;
    Hashtbl.add status_bar_frames "red_healthbar" red_healthbar;
    Hashtbl.add status_bar_frames "manabar" manabar;
    Hashtbl.add status_bar_frames "blue_manabar" blue_manabar;
    Hashtbl.add status_bar_frames "portrait_frame" portrait_frame;
    Hashtbl.add status_bar_frames "gold_bar" gold_bar;
    Hashtbl.add status_bar_frames "menu" menu;
    {
      sprite_sheet = hud_spritesheet;
      health = 100;
      mana = 100;
      portrait = load_texture "assets/HUD/fire_knight.png";
      frames = Sprite.create hud_spritesheet status_bar_frames 5.0;
    }

  let draw_helper statusbar name x y =
    let height = Rectangle.height (Sprite.dest_rect statusbar.frames name) in
    let drawing_position = Vector2.create x (y +. height) in

    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames name)
      (Sprite.dest_rect statusbar.frames name)
      drawing_position 0. Color.raywhite

  let draw_restart_screen statusbar score =
    let height = 44. *. 4. in
    let drawing_position = Vector2.create (-400.) (-300. +. height) in
    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "menu")
      (Rectangle.create 0. 0. (44. *. 18.) (height *. 2.5))
      drawing_position 0. Color.raywhite;
    let score_string = "SCORE: " ^ string_of_int score in
    let restart_string = "PRESS R TO RESTART" in
    draw_text score_string 500 275 50 Color.raywhite;
    draw_text restart_string 500 375 50 Color.raywhite

  let draw_boss_healthbar statusbar hp =
    let drawing_position = Vector2.create (-400.) (-100. +. 56.) in
    draw_texture_pro statusbar.sprite_sheet
      (Rectangle.create (-135.) 20. (-52.) 7.)
      (Rectangle.create 0. 0. (52. *. 28. *. hp) (7. *. 8.))
      drawing_position 0. Color.raywhite;
    draw_text "FROST GUARDIAN" 700 10 45 Color.raywhite

  let draw_red_healthbar statusbar hp =
    let height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "red_healthbar")
    in
    let drawing_position = Vector2.create (-135.5) (-26. +. height) in
    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "red_healthbar")
      (Rectangle.create 0. 0. (49. *. 5. *. hp) (3. *. 5.))
      drawing_position 0. Color.raywhite

  let draw_gold gold =
    let gold_string = string_of_int gold in
    draw_text gold_string 170 75 35 Color.raywhite

  let draw_blue_manabar statusbar mana =
    let height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "blue_manabar")
    in
    let drawing_position = Vector2.create (-135.5) (-56. +. height) in
    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "blue_manabar")
      (Rectangle.create 0. 0. (42. *. 5. *. mana) (3. *. 5.))
      drawing_position 0. Color.raywhite

  let draw_portrait statusbar =
    draw_helper statusbar "portrait_frame" 0. (-120.);
    let portrait_src_rect = Rectangle.create 0. 0. 64. 64. in
    let portrait_dest_rect =
      Rectangle.create 0. 0. (64. *. 1.75) (64. *. 1.75)
    in
    let portrait_height = Rectangle.height portrait_dest_rect in
    let portrait_drawing_position =
      Vector2.create (-10.) (-110. +. portrait_height)
    in
    draw_texture_pro statusbar.portrait portrait_src_rect portrait_dest_rect
      portrait_drawing_position 0. Color.raywhite

  let draw_manabar statusbar = draw_helper statusbar "manabar" (-130.) (-65.)

  let draw_healthbar statusbar =
    draw_helper statusbar "healthbar" (-130.) (-35.)

  let draw_goldbar statusbar = draw_helper statusbar "gold_bar" (-130.) (-120.)

  let draw statusbar =
    draw_portrait statusbar;
    draw_goldbar statusbar;
    draw_manabar statusbar;
    draw_healthbar statusbar
end
