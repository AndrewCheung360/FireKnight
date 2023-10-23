module Knight = struct
  open Constants
  open Raylib
  open Frames.KnightFrames
  open States.StateManager

  type t = {
    mutable position : Vector2.t;
    mutable velocity : Vector2.t;
    animations : Sprites.AnimatedSprite.t;
    mutable state : States.StateManager.t;
  }

  let create_knight_animation () =
    let knight_spritesheet =
      load_texture "assets/characters/Fire_Knight/Fire_Knight_SpriteSheet.png"
    in
    let knight_animations = Hashtbl.create 10 in
    Hashtbl.add knight_animations "idle" idle;
    Hashtbl.add knight_animations "run" run;
    Hashtbl.add knight_animations "attack_1" atk1;
    Hashtbl.add knight_animations "attack_2" atk2;
    Hashtbl.add knight_animations "attack_3" atk3;
    Hashtbl.add knight_animations "ult" ult;

    let animations =
      Sprites.AnimatedSprite.create knight_spritesheet knight_animations
        Constants.knight_scale
    in
    let position = Vector2.create 0. Constants.ground_y in
    let velocity = Vector2.create 0. 0. in
    let state = Idle in
    { position; velocity; animations; state }

  let handle_idle knight =
    Sprites.AnimatedSprite.switch_animation knight.animations "idle"

  let handle_run knight =
    Sprites.AnimatedSprite.switch_animation knight.animations "run";
    let knight_vel = Vector2.x knight.velocity in
    let vel_x =
      if knight.state = RunRight then
        max (-.Constants.max_vel_x) (knight_vel -. Constants.accel_x)
      else min Constants.max_vel_x (knight_vel +. Constants.accel_x)
    in
    let new_position = Vector2.add knight.position (Vector2.create vel_x 0.0) in
    let new_x = min Constants.left_boundary (Vector2.x new_position) in
    let new_x = max Constants.right_boundary new_x in
    knight.velocity <- Vector2.create vel_x (Vector2.y knight.velocity);
    knight.position <- Vector2.create new_x (Vector2.y knight.position)

  let handle_attack_1 knight =
    if Sprites.AnimatedSprite.is_animation_finished knight.animations then begin
      knight.state <- Idle;
      Sprites.AnimatedSprite.switch_animation knight.animations "idle"
    end
    else Sprites.AnimatedSprite.switch_animation knight.animations "attack_1"

  let handle_attack_2 knight =
    if Sprites.AnimatedSprite.is_animation_finished knight.animations then begin
      knight.state <- Idle;
      Sprites.AnimatedSprite.switch_animation knight.animations "idle"
    end
    else Sprites.AnimatedSprite.switch_animation knight.animations "attack_2"

  let handle_attack_3 knight =
    if Sprites.AnimatedSprite.is_animation_finished knight.animations then begin
      knight.state <- Idle;
      Sprites.AnimatedSprite.switch_animation knight.animations "idle"
    end
    else Sprites.AnimatedSprite.switch_animation knight.animations "attack_3"

  let handle_ultimate knight =
    if Sprites.AnimatedSprite.is_animation_finished knight.animations then begin
      knight.state <- Idle;
      Sprites.AnimatedSprite.switch_animation knight.animations "idle"
    end
    else Sprites.AnimatedSprite.switch_animation knight.animations "ult"

  let handle_key_input knight =
    if
      (not (Sprites.AnimatedSprite.is_animation_finished knight.animations))
      && not (is_loop_state knight.state)
    then knight.state
    else if is_key_pressed Key.J then Attack1Right
    else if is_key_pressed Key.K then Attack2Right
    else if is_key_pressed Key.L then Attack3Right
    else if is_key_pressed Key.U then UltimateRight
    else if is_key_down Key.D then RunRight
    else if is_key_down Key.A then RunLeft
    else Idle

  let handle_input knight =
    knight.state <- handle_key_input knight;
    if knight.state = Attack1Right then handle_attack_1 knight
    else if knight.state = Attack2Right then handle_attack_2 knight
    else if knight.state = Attack3Right then handle_attack_3 knight
    else if knight.state = UltimateRight then handle_ultimate knight
    else if knight.state = RunRight || knight.state = RunLeft then
      handle_run knight
    else handle_idle knight

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
