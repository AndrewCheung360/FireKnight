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

  let draw_portrait statusbar =
    let portrait_frame_height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "portrait_frame")
    in
    let p_frame_drawing_position =
      Vector2.create 0. (-120. +. portrait_frame_height)
    in

    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "portrait_frame")
      (Sprite.dest_rect statusbar.frames "portrait_frame")
      p_frame_drawing_position 0. Color.raywhite;
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
    let manabar_height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "manabar")
    in
    let manabar_drawing_position =
      Vector2.create (-130.) (-65. +. manabar_height)
    in

    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "manabar")
      (Sprite.dest_rect statusbar.frames "manabar")
      manabar_drawing_position 0. Color.raywhite;
    let blue_manabar_height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "blue_manabar")
    in
    let blue_manabar_drawing_position =
      Vector2.create (-135.5) (-56. +. blue_manabar_height)
    in

    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "blue_manabar")
      (Sprite.dest_rect statusbar.frames "blue_manabar")
      blue_manabar_drawing_position 0. Color.raywhite

  let draw_healthbar statusbar =
    let healthbar_height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "healthbar")
    in
    let healthbar_drawing_position =
      Vector2.create (-130.) (-35. +. healthbar_height)
    in

    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "healthbar")
      (Sprite.dest_rect statusbar.frames "healthbar")
      healthbar_drawing_position 0. Color.raywhite;
    let red_healthbar_height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "red_healthbar")
    in
    let red_healthbar_drawing_position =
      Vector2.create (-135.5) (-26. +. red_healthbar_height)
    in

    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "red_healthbar")
      (Sprite.dest_rect statusbar.frames "red_healthbar")
      red_healthbar_drawing_position 0. Color.raywhite

  let draw_goldbar statusbar =
    let goldbar_height =
      Rectangle.height (Sprite.dest_rect statusbar.frames "gold_bar")
    in
    let goldbar_drawing_position =
      Vector2.create (-130.) (-120. +. goldbar_height)
    in

    draw_texture_pro statusbar.sprite_sheet
      (Sprite.src_rect statusbar.frames "gold_bar")
      (Sprite.dest_rect statusbar.frames "gold_bar")
      goldbar_drawing_position 0. Color.raywhite

  let draw statusbar =
    draw_portrait statusbar;
    draw_goldbar statusbar;
    draw_manabar statusbar;
    draw_healthbar statusbar
end
