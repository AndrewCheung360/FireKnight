module StatusBar = struct
  open Raylib
  open Frames
  open Sprites

  type frame = Sprite.frame

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
    Hashtbl.add status_bar_frames "healthbar" HudFrames.healthbar;
    Hashtbl.add status_bar_frames "red_healthbar" HudFrames.red_healthbar;
    Hashtbl.add status_bar_frames "manabar" HudFrames.manabar;
    Hashtbl.add status_bar_frames "blue_manabar" HudFrames.blue_manabar;
    Hashtbl.add status_bar_frames "portrait_frame" HudFrames.portrait_frame;
    Hashtbl.add status_bar_frames "gold_bar" HudFrames.gold_bar;
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

  let draw_manabar statusbar =
    draw_helper statusbar "manabar" (-130.) (-65.);
    draw_helper statusbar "blue_manabar" (-135.5) (-56.)

  let draw_healthbar statusbar =
    draw_helper statusbar "healthbar" (-130.) (-35.);
    draw_helper statusbar "red_healthbar" (-135.5) (-26.)

  let draw_goldbar statusbar = draw_helper statusbar "gold_bar" (-130.) (-120.)

  let draw statusbar =
    draw_portrait statusbar;
    draw_goldbar statusbar;
    draw_manabar statusbar;
    draw_healthbar statusbar
end
