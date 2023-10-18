module Knight = struct
  open Constants
  open Raylib
  open Frames.KnightFrames

  type t = {
    mutable position : Vector2.t;
    mutable velocity : Vector2.t;
    animations : Sprites.AnimatedSprite.t;
  }

  let create_knight_animation () =
    let knight_spritesheet =
      load_texture "assets/characters/Fire_Knight/Fire_Knight_SpriteSheet.png"
    in
    let knight_animations = Hashtbl.create 10 in
    Hashtbl.add knight_animations "idle" idle;
    Hashtbl.add knight_animations "run" run;

    let animations =
      Sprites.AnimatedSprite.create knight_spritesheet knight_animations
        Constants.knight_scale
    in
    let position = Vector2.create 0. Constants.ground_y in
    let velocity = Vector2.create 0. 0. in
    { position; velocity; animations }

  let handle_input knight =
    if is_key_down Key.D || is_key_down Key.A then begin
      Sprites.AnimatedSprite.switch_animation knight.animations "run";
      let vel_x =
        if is_key_down Key.D then -.Constants.move_vel else Constants.move_vel
      in
      let new_position =
        Vector2.add knight.position (Vector2.create vel_x 0.0)
      in
      let new_x = min Constants.left_boundary (Vector2.x new_position) in
      let new_x = max Constants.right_boundary new_x in
      knight.velocity <- Vector2.create vel_x (Vector2.y knight.velocity);
      knight.position <- Vector2.create new_x (Vector2.y knight.position)
    end
    else Sprites.AnimatedSprite.switch_animation knight.animations "idle"

  let update knight =
    handle_input knight;
    Sprites.AnimatedSprite.update_frame_animation knight.animations

  let draw knight =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect knight.animations)
    in
    let drawing_position =
      Vector2.create
        (Vector2.x knight.position)
        (Vector2.y knight.position +. frame_height)
    in

    draw_texture_pro
      (Sprites.AnimatedSprite.get_spritesheet knight.animations)
      (Sprites.AnimatedSprite.src_rect knight.animations)
      (Sprites.AnimatedSprite.dest_rect knight.animations)
      drawing_position 0. Color.raywhite
end
