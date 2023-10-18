open Constants
open Raylib
open Color
open Animatedsprite
open Knightframes

let width = Constants.screen_width
let height = Constants.screen_height
let fps = Constants.fps
let position = ref (Vector2.create 0. (-700.))
let vel = Constants.move_vel
let left_boundary = Vector2.create 0. 0.
let right_boundary = Vector2.create (-960.) 0.

let setup () =
  init_window width height "Fire Knight";
  set_target_fps fps;

  let knight_spritesheet =
    load_texture "assets/characters/Fire_Knight/Fire_Knight_SpriteSheet.png"
  in
  let knight_animations = Hashtbl.create 10 in
  Hashtbl.add knight_animations "idle" Knightframes.idle;
  Hashtbl.add knight_animations "run" Knightframes.run;

  Animatedsprite.create knight_spritesheet knight_animations 4.0

let handle_input knight_anim =
  if is_key_down Key.D || is_key_down Key.A then begin
    Animatedsprite.switch_animation knight_anim "run";
    let movement = if is_key_down Key.D then -.vel else vel in
    let new_position = Vector2.add !position (Vector2.create movement 0.0) in
    let new_x = min (Vector2.x left_boundary) (Vector2.x new_position) in
    let new_x = max (Vector2.x right_boundary) new_x in
    position := Vector2.create new_x (Vector2.y !position)
  end
  else Animatedsprite.switch_animation knight_anim "idle"

let rec loop knight_anim =
  if window_should_close () then close_window () else handle_input knight_anim;
  Animatedsprite.update_frame_animation knight_anim;

  begin_drawing ();
  clear_background raywhite;

  let frame_height = Rectangle.height (Animatedsprite.dest_rect knight_anim) in
  let character_position = !position in
  let drawing_position =
    Vector2.create
      (Vector2.x character_position)
      (Vector2.y character_position +. frame_height)
  in

  draw_texture_pro
    (Animatedsprite.get_spritesheet knight_anim)
    (Animatedsprite.src_rect knight_anim)
    (Animatedsprite.dest_rect knight_anim)
    drawing_position 0. raywhite;

  end_drawing ();
  loop knight_anim

let () = setup () |> loop
