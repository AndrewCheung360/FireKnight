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
  }

  let create_frostguardian_animation () =
    let guardian_spritesheet =
      load_texture
        "assets/characters/Frost_Guardian/Frost_Guardian_SpriteSheet.png"
    in
    let guardian_animations = Hashtbl.create 10 in
    Hashtbl.add guardian_animations "idle" idle;

    let animations =
      Sprites.AnimatedSprite.create guardian_spritesheet guardian_animations
        Constants.frost_guardian_scale
    in
    let position = Vector2.create (-700.) Constants.ground_y in
    let velocity = Vector2.create 0. 0. in
    let state = Idle in
    { position; velocity; animations; state }

  let handle_idle guardian =
    Sprites.AnimatedSprite.switch_animation guardian.animations "idle"

  let handle_state guardian = if guardian.state = Idle then handle_idle guardian

  let update guardian =
    handle_state guardian;
    Sprites.AnimatedSprite.update_frame_animation guardian.animations

  let draw guardian =
    let frame_height =
      Rectangle.height (Sprites.AnimatedSprite.dest_rect guardian.animations)
    in
    let drawing_position =
      Vector2.create
        (Vector2.x guardian.position)
        (Vector2.y guardian.position +. frame_height)
    in

    draw_texture_pro
      (Sprites.AnimatedSprite.get_spritesheet guardian.animations)
      (Sprites.AnimatedSprite.src_rect guardian.animations)
      (Sprites.AnimatedSprite.dest_rect guardian.animations)
      drawing_position 0. Color.raywhite
end
