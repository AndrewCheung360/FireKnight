(** This module defines both a Sprite and an Animated Sprite *)

type frame = {
  frame_x : float;
  frame_y : float;
  frame_width : float;
  frame_height : float;
}
(** The type representing a single frame of an animation or sprite *)

(** This module defines a Sprite, consisting of a texture and frames *)
module Sprite : sig
  type t = {
    sprite_sheet : Raylib.Texture.t;
    frames : (string, frame) Hashtbl.t;
    scale : float;
  }
  (** The type representing a Sprite, use texture and a hashtable of frames. *)

  val create : Raylib.Texture.t -> (string, frame) Hashtbl.t -> float -> t
  (** Create a new Sprite with the given texture, frame hashtable, and scale. *)

  val get_frame : t -> string -> frame
  (** Retrieve a frame from the Sprite using its string key. *)

  val get_spritesheet : t -> Raylib.Texture.t
  (** Retrieve the texture of the Sprite. *)

  val get_src_x : t -> string -> float
  (** Retrieve the x-coordinate of a frame within the Sprite. *)

  val get_src_y : t -> string -> float
  (** Retrieve the y-coordinate of a frame within the Sprite. *)

  val get_src_width : t -> string -> float
  (** Retrieve the width of a frame within the Sprite. *)

  val get_src_height : t -> string -> float
  (** Retrieve the height of a frame within the Sprite. *)

  val src_rect : t -> string -> Raylib.Rectangle.t
  (** Get the source rectangle for a specified frame in the Sprite. *)

  val dest_rect : t -> string -> Raylib.Rectangle.t
  (** Get the destination rectangle for a specified frame in the Sprite. *)
end

(** This module defines an AnimatedSprite, which extends a Sprite with animation *)
module AnimatedSprite : sig
  type t = {
    sprite_sheet : Raylib.Texture.t;
    animations : (string, frame array * float array) Hashtbl.t;
    scale : float;
    mutable current_frame : int;
    mutable frame_timer : float;
    mutable current_animation : string;
  }
  (** The type representing an AnimatedSprite *)

  val create :
    Raylib.Texture.t ->
    (string, frame array * float array) Hashtbl.t ->
    float ->
    t
  (** Create a new AnimatedSprite with the given texture, hashtable, scale*)

  val get_current_animation : t -> frame array * float array
  (** Get the current animation (frames and timings) of the AnimatedSprite. *)

  val update_frame_animation : t -> unit
  (** Update the frame animation based on the timer and animation sequence. *)

  val switch_animation : t -> string -> unit
  (** Switch the current animation of the AnimatedSprite to the specified one. *)

  val current_frame_index : t -> int
  (** Get the index of the current frame in the animation. *)

  val current_frame : t -> frame
  (** Get the current frame of the animation. *)

  val get_src_x : t -> float
  (** Retrieve the x-coordinate of the current frame in the AnimatedSprite. *)

  val get_src_y : t -> float
  (** Retrieve the y-coordinate of the current frame in the AnimatedSprite. *)

  val get_src_width : t -> float
  (** Retrieve the width of the current frame in the AnimatedSprite. *)

  val get_spritesheet : t -> Raylib.Texture.t
  (** Retrieve the texture of the AnimatedSprite. *)

  val get_src_height : t -> float
  (** Retrieve the height of the current frame in the AnimatedSprite. *)

  val get_anim_name : t -> string
  (** Retrieve the name of the current animation in the AnimatedSprite. *)

  val src_rect : t -> Raylib.Rectangle.t
  (** Get the source rectangle for the current frame in the AnimatedSprite. *)

  val dest_rect : t -> Raylib.Rectangle.t
  (** Get the destination rectangle for the current frame in the AnimatedSprite. *)

  val is_animation_finished : t -> bool
  (** Check if the current animation of the AnimatedSprite is finished. *)
end
