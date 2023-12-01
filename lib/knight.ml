module Knight = struct
  open Constants
  open Raylib
  open Frames.KnightFrames
  open States.KnightStates

  type t = {
    mutable position : Vector2.t;
    mutable velocity : Vector2.t;
    animations : Sprites.AnimatedSprite.t;
    mutable state : States.KnightStates.t;
    mutable attack_landed : bool;
    mutable health : int;
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
    Hashtbl.add knight_animations "jump" jump;
    Hashtbl.add knight_animations "fall" fall;
    Hashtbl.add knight_animations "attack_3" atk3;
    Hashtbl.add knight_animations "ult" ult;

    let animations =
      Sprites.AnimatedSprite.create knight_spritesheet knight_animations
        Constants.knight_scale
    in
    let position = Vector2.create 0. Constants.ground_y in
    let velocity = Vector2.create 0. 0. in
    let state = Idle in
    {
      position;
      velocity;
      animations;
      state;
      attack_landed = false;
      health = 1000;
    }

  let handle_idle knight =
    Sprites.AnimatedSprite.switch_animation knight.animations "idle"

  let handle_run knight =
    if Vector2.y knight.position = Constants.ground_y then
      Sprites.AnimatedSprite.switch_animation knight.animations "run"
    else if
      Vector2.y knight.position > Constants.ground_y
      && Vector2.y knight.velocity < 0.
    then Sprites.AnimatedSprite.switch_animation knight.animations "fall";
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

  let handle_jump knight =
    if Vector2.y knight.velocity > 0. then
      Sprites.AnimatedSprite.switch_animation knight.animations "jump"
    else Sprites.AnimatedSprite.switch_animation knight.animations "fall";

    if Vector2.y knight.position = Constants.ground_y then
      knight.velocity <-
        Vector2.create (Vector2.x knight.velocity) Constants.jump_force;

    let new_position =
      Vector2.add knight.position
        (Vector2.create (Vector2.x knight.velocity) (Vector2.y knight.velocity))
    in
    let new_y = min Constants.upper_boundary (Vector2.y new_position) in
    let new_y = max Constants.ground_y new_y in
    knight.position <- Vector2.create (Vector2.x knight.position) new_y

  let handle_fall knight =
    if Vector2.y knight.velocity > 0. then
      Sprites.AnimatedSprite.switch_animation knight.animations "jump"
    else Sprites.AnimatedSprite.switch_animation knight.animations "fall";
    knight.velocity <-
      Vector2.create (Vector2.x knight.velocity) (Vector2.y knight.velocity)

  let apply_grav knight =
    if Vector2.y knight.velocity > Constants.ground_y then
      knight.velocity <-
        Vector2.create
          (Vector2.x knight.velocity)
          (Vector2.y knight.velocity +. Constants.grav);

    let new_position =
      Vector2.add knight.position
        (Vector2.create 0.0 (Vector2.y knight.velocity))
    in

    let new_y = max (Vector2.y new_position) Constants.ground_y in
    knight.position <- Vector2.create (Vector2.x knight.position) new_y

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
    let donothing =
      if Vector2.y knight.position > Constants.ground_y then Falling else Idle
    in
    if
      (not (Sprites.AnimatedSprite.is_animation_finished knight.animations))
      && not (is_loop_state knight.state)
    then knight.state
    else if is_key_pressed Key.J then
      if Vector2.y knight.position = Constants.ground_y then Attack1Right
      else knight.state
    else if is_key_pressed Key.K then
      if Vector2.y knight.position = Constants.ground_y then Attack2Right
      else knight.state
    else if is_key_pressed Key.L then
      if Vector2.y knight.position = Constants.ground_y then Attack3Right
      else knight.state
    else if is_key_pressed Key.U then
      if Vector2.y knight.position = Constants.ground_y then UltimateRight
      else knight.state
    else if is_key_down Key.Space then
      if Vector2.y knight.position = Constants.ground_y then Jump
      else knight.state
    else if is_key_down Key.D && is_key_down Key.A then donothing
    else if is_key_down Key.D then RunRight
    else if is_key_down Key.A then RunLeft
    else donothing

  let handle_input knight =
    knight.state <- handle_key_input knight;
    match knight.state with
    | Attack1Right -> handle_attack_1 knight
    | Attack2Right -> handle_attack_2 knight
    | Jump -> handle_jump knight
    | Falling -> handle_fall knight
    | Attack3Right -> handle_attack_3 knight
    | UltimateRight -> handle_ultimate knight
    | RunRight | RunLeft -> handle_run knight
    | Idle -> handle_idle knight

  let update knight =
    apply_grav knight;
    handle_input knight;

    Sprites.AnimatedSprite.update_frame_animation knight.animations;
    if Sprites.AnimatedSprite.is_animation_finished knight.animations then
      knight.attack_landed <- false

  let get_frame_height knight =
    Rectangle.height (Sprites.AnimatedSprite.dest_rect knight.animations)

  let get_frame_width knight =
    Rectangle.width (Sprites.AnimatedSprite.dest_rect knight.animations)

  let hurt_box knight =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect knight.animations)
    in
    let drawing_position =
      Vector2.create
        (Vector2.x knight.position)
        (Vector2.y knight.position +. frame_height)
    in

    let rectangle_width = 250 in
    let rectangle_height = 180 in
    Rectangle.create
      (-.Vector2.x drawing_position)
      (-.(Vector2.y drawing_position -. frame_height)
      -. float_of_int rectangle_height)
      (float_of_int rectangle_width)
      (float_of_int rectangle_height)

  let hit_box_helper x y w h knight =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect knight.animations)
    in
    let knight_pos_x = Vector2.x knight.position in
    let knight_pos_y = Vector2.y knight.position +. frame_height in

    Rectangle.create (-.knight_pos_x +. x) (-.knight_pos_y +. y)
      (float_of_int w) (float_of_int h)

  let hit_box knight =
    match
      ( knight.state,
        Sprites.AnimatedSprite.current_frame_index knight.animations )
    with
    | Attack1Right, 4 -> Some (hit_box_helper 200. 0. 176 328 knight)
    | Attack2Right, n when n = 4 || n = 5 || n = 6 ->
        Some
          (hit_box_helper 0. 0.
             (int_of_float (get_frame_width knight))
             (int_of_float (get_frame_height knight))
             knight)
    | Attack3Right, 4 -> Some (hit_box_helper 172. 0. 284 276 knight)
    | UltimateRight, 12 ->
        Some
          (hit_box_helper 0. 0.
             (int_of_float (get_frame_width knight))
             (int_of_float (get_frame_height knight))
             knight)
    | _ -> None

  let draw knight =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect knight.animations)
    in
    let drawing_position =
      Vector2.create
        (Vector2.x knight.position)
        (Vector2.y knight.position +. frame_height)
    in

    let rectangle_width = 250 in
    let rectangle_height = 180 in
    let red_color = Color.red in

    draw_rectangle_lines
      (int_of_float (-.Vector2.x drawing_position))
      (int_of_float
         (-.(Vector2.y drawing_position -. frame_height)
         -. float_of_int rectangle_height))
      rectangle_width rectangle_height red_color;

    if hit_box knight <> None then
      draw_rectangle_lines_ex (Option.get (hit_box knight)) 2. Color.green;
    draw_texture_pro
      (Sprites.AnimatedSprite.get_spritesheet knight.animations)
      (Sprites.AnimatedSprite.src_rect knight.animations)
      (Sprites.AnimatedSprite.dest_rect knight.animations)
      drawing_position 0. Color.raywhite
end
