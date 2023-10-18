module Animatedsprite = struct
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
    frames : frame array;
    frame_durations : float array;
    scale : float;
    mutable current_frame : int;
    mutable frame_timer : float;
    mutable current_animation : string;
  }

  let create sprite_sheet frames scale frame_durations =
    {
      sprite_sheet;
      frames;
      scale;
      frame_durations;
      current_frame = 0;
      frame_timer = 0.;
      current_animation = "idle";
    }

  let update_frame_animation anim =
    match anim.frame_durations with
    | [||] -> ()
    | duration ->
        if anim.frame_timer >= duration.(anim.current_frame) then begin
          anim.current_frame <-
            (anim.current_frame + 1) mod Array.length anim.frame_durations;
          anim.frame_timer <- 0.
        end
        else
          anim.frame_timer <-
            anim.frame_timer +. (1. /. float_of_int Constants.fps)

  let switch_animation anim state = anim.current_animation <- state
  let current_frame_index anim = anim.current_frame
  let current_frame anim = anim.frames.(anim.current_frame)
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
end
