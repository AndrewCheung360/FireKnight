module Animated_Sprite = struct
  open Raylib
  open Constants

  type t = {
    sprite_sheet : Texture.t;
    frame_width : int;
    frame_height : int;
    frame_durations : float list;
    mutable current_frame : int;
    mutable frame_timer : float;
    mutable current_animation : string;
  }

  let create sprite_sheet frame_width frame_height frame_durations =
    {
      sprite_sheet;
      frame_width;
      frame_height;
      frame_durations;
      current_frame = 0;
      frame_timer = 0.;
      current_animation = "idle";
    }

  let update_frame_animation anim =
    match anim.frame_durations with
    | [] -> ()
    | duration :: _ ->
        if anim.frame_timer >= duration then begin
          anim.current_frame <-
            (anim.current_frame + 1) mod List.length anim.frame_durations;
          anim.frame_timer <- 0.
        end
        else
          anim.frame_timer <-
            anim.frame_timer +. (1. /. float_of_int Constants.fps)

  let switch_animation anim state = anim.current_animation <- state
  let current_frame_index anim = anim.current_frame

  let source_rect anim =
    let x_offset = anim.current_frame * anim.frame_width in
    let y_offset =
      if anim.current_animation = "running" then anim.frame_height else 0
    in
    Rectangle.create (float_of_int x_offset) (float_of_int y_offset)
      (float_of_int anim.frame_width)
      (float_of_int anim.frame_height)
end
