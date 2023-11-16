module Sprite = struct
  open Raylib

  type frame = {
    frame_x : float;
    frame_y : float;
    frame_width : float;
    frame_height : float;
  }

  type t = {
    sprite_sheet : Texture.t;
    frames : (string, frame) Hashtbl.t;
    scale : float;
  }

  let create sprite_sheet frames scale = { sprite_sheet; frames; scale }
  let get_frame sprite name = Hashtbl.find sprite.frames name
  let get_spritesheet sprite = sprite.sprite_sheet

  let get_src_x sprite name =
    get_frame sprite name |> fun frame -> frame.frame_x

  let get_src_y sprite name =
    get_frame sprite name |> fun frame -> frame.frame_y

  let get_src_width sprite name =
    get_frame sprite name |> fun frame -> frame.frame_width

  let get_src_height sprite name =
    get_frame sprite name |> fun frame -> frame.frame_height

  let src_rect sprite name =
    Rectangle.create (get_src_x sprite name) (get_src_y sprite name)
      (get_src_width sprite name)
      (get_src_height sprite name)

  let dest_rect sprite name =
    Rectangle.create 0. 0.
      (get_src_width sprite name *. sprite.scale)
      (get_src_height sprite name *. sprite.scale)
end

module AnimatedSprite = struct
  open Raylib
  open Constants

  type frame = {
    frame_x : float;
    frame_y : float;
    frame_width : float;
    frame_height : float;
  }

  type t = {
    sprite_sheet : Texture.t;
    (* The keys for the hashtable are the animation names and has a tuple as
       it's values with the rectangles and the duration array *)
    animations : (string, frame array * float array) Hashtbl.t;
    scale : float;
    mutable current_frame : int;
    mutable frame_timer : float;
    mutable current_animation : string;
  }

  let create sprite_sheet animations scale =
    {
      sprite_sheet;
      animations;
      scale;
      current_frame = 0;
      frame_timer = 0.;
      current_animation = "idle";
    }

  let get_current_animation anim =
    Hashtbl.find anim.animations anim.current_animation

  let update_frame_animation anim =
    let frames, durations = get_current_animation anim in
    anim.frame_timer <- anim.frame_timer +. (1. /. float_of_int Constants.fps);
    if anim.frame_timer >= durations.(anim.current_frame) then begin
      anim.frame_timer <- 0.;
      anim.current_frame <- (anim.current_frame + 1) mod Array.length frames
    end

  let switch_animation anim name =
    if not (String.equal anim.current_animation name) then (
      anim.current_animation <- name;
      anim.current_frame <- 0;
      anim.frame_timer <- 0.)

  let current_frame_index anim = anim.current_frame

  let current_frame anim =
    let frames, _ = get_current_animation anim in
    frames.(anim.current_frame)

  let get_src_x anim = current_frame anim |> fun frame -> frame.frame_x
  let get_src_y anim = current_frame anim |> fun frame -> frame.frame_y
  let get_src_width anim = current_frame anim |> fun frame -> frame.frame_width
  let get_spritesheet anim = anim.sprite_sheet

  let get_src_height anim =
    current_frame anim |> fun frame -> frame.frame_height

  let get_anim_name anim = anim.current_animation

  let src_rect anim =
    Rectangle.create (get_src_x anim) (get_src_y anim) (get_src_width anim)
      (get_src_height anim)

  let dest_rect anim =
    Rectangle.create 0. 0.
      (get_src_width anim *. anim.scale)
      (get_src_height anim *. anim.scale)

  (** Returns true if animation is finished by checking if the current frame is
      the last frame*)
  let is_animation_finished anim =
    let frames, _ = Hashtbl.find anim.animations anim.current_animation in
    if anim.current_frame = Array.length frames - 1 then true else false
end
