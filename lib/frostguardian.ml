module FrostGuardian = struct
  open Constants
  open Raylib
  open Frames.FrostGuardianFrames
  open States.GuardianStates

  type t = {
    mutable position : Vector2.t;
    mutable velocity : Vector2.t;
    animations : Sprites.AnimatedSprite.t;
    mutable state : States.GuardianStates.t;
    mutable idlecounter : int;
    mutable attack_landed : bool;
    mutable hurt : bool;
    mutable health : float;
  }

  let create_frostguardian_animation () =
    let guardian_spritesheet =
      load_texture
        "assets/characters/Frost_Guardian/Frost_Guardian_SpriteSheet.png"
    in
    let guardian_animations = Hashtbl.create 10 in
    Hashtbl.add guardian_animations "idle" idle;
    Hashtbl.add guardian_animations "intro" intro;
    Hashtbl.add guardian_animations "punch" punch;
    Hashtbl.add guardian_animations "hurt" hurt;

    let animations =
      Sprites.AnimatedSprite.create guardian_spritesheet guardian_animations
        Constants.frost_guardian_scale
    in
    let position = Vector2.create (-900.) Constants.ground_y in
    let velocity = Vector2.create 0. 0. in
    let state = Intro in
    let idlecounter = 0 in
    {
      position;
      velocity;
      animations;
      state;
      idlecounter;
      attack_landed = false;
      hurt = false;
      health = 10000.;
    }

  let handle_idle guardian =
    Sprites.AnimatedSprite.switch_animation guardian.animations "idle";
    guardian.idlecounter <- guardian.idlecounter + 1;
    if
      Sprites.AnimatedSprite.is_animation_finished guardian.animations
      && guardian.idlecounter >= 210
    then begin
      guardian.idlecounter <- 0;
      guardian.state <- Punch
    end

  let handle_punch guardian =
    Sprites.AnimatedSprite.switch_animation guardian.animations "punch";
    if Sprites.AnimatedSprite.is_animation_finished guardian.animations then begin
      guardian.state <- Idle;
      let position = Vector2.create (-900.) Constants.ground_y in
      guardian.position <- position
    end
    else
      let frame_index =
        Sprites.AnimatedSprite.current_frame_index guardian.animations
      in
      if frame_index = 6 || frame_index = 7 || frame_index = 8 then
        let position = Vector2.create (-600.) Constants.ground_y in
        guardian.position <- position
      else
        let position = Vector2.create (-900.) Constants.ground_y in
        guardian.position <- position

  let handle_intro guardian =
    if Sprites.AnimatedSprite.is_animation_finished guardian.animations then
      guardian.state <- Idle;
    Sprites.AnimatedSprite.switch_animation guardian.animations "intro"

  let handle_hurt guardian =
    if Sprites.AnimatedSprite.is_animation_finished guardian.animations then begin
      guardian.state <- Idle;
      Sprites.AnimatedSprite.switch_animation guardian.animations "idle"
    end
    else Sprites.AnimatedSprite.switch_animation guardian.animations "hurt"

  let handle_state guardian =
    match guardian.state with
    | Hurt -> handle_hurt guardian
    | Intro -> handle_intro guardian
    | Punch -> handle_punch guardian
    | _ -> handle_idle guardian

  let update guardian =
    if guardian.hurt then guardian.state <- Hurt;
    handle_state guardian;
    Sprites.AnimatedSprite.update_frame_animation guardian.animations;
    if Sprites.AnimatedSprite.is_animation_finished guardian.animations then begin
      guardian.attack_landed <- false;
      guardian.hurt <- false
    end

  let hurt_box guardian =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect guardian.animations)
    in
    let drawing_position =
      Vector2.create
        (Vector2.x guardian.position)
        (Vector2.y guardian.position +. frame_height)
    in

    let rectangle_width = 450 in
    let rectangle_height = 500 in
    Rectangle.create
      (-.Vector2.x drawing_position)
      (-.(Vector2.y drawing_position -. frame_height)
      -. float_of_int rectangle_height)
      (float_of_int rectangle_width)
      (float_of_int rectangle_height)

  let hit_box_helper x y w h guardian =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect guardian.animations)
    in
    let guardian_pos_x = Vector2.x guardian.position in
    let guardian_pos_y = Vector2.y guardian.position +. frame_height in

    Rectangle.create (-.guardian_pos_x +. x) (-.guardian_pos_y +. y)
      (float_of_int w) (float_of_int h)

  let hit_box guardian =
    match
      ( guardian.state,
        Sprites.AnimatedSprite.current_frame_index guardian.animations )
    with
    | Punch, 6 -> Some (hit_box_helper 0. 88. 400 300 guardian)
    | _ -> None

  let draw guardian =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect guardian.animations)
    in
    let drawing_position =
      Vector2.create
        (Vector2.x guardian.position)
        (Vector2.y guardian.position +. frame_height)
    in

    let rectangle_width = 450 in
    let rectangle_height = 500 in
    let red_color = Color.red in

    draw_rectangle_lines
      (int_of_float (-.Vector2.x drawing_position))
      (int_of_float
         (-.(Vector2.y drawing_position -. frame_height)
         -. float_of_int rectangle_height))
      rectangle_width rectangle_height red_color;
    if hit_box guardian <> None then
      draw_rectangle_lines_ex (Option.get (hit_box guardian)) 2. Color.green;
    draw_texture_pro
      (Sprites.AnimatedSprite.get_spritesheet guardian.animations)
      (Sprites.AnimatedSprite.src_rect guardian.animations)
      (Sprites.AnimatedSprite.dest_rect guardian.animations)
      drawing_position 0. Color.raywhite
end
