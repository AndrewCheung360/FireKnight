(** The AnimatedSprite module is responsible for handling sprite animations. It
    takes a sprite sheet and manages how sprites are presented on the frame. *)
module AnimatedSprite : sig
  type frame = {
    frame_x : float; (* X-coordinate of the sprite frame on the sprite sheet. *)
    frame_y : float; (* Y-coordinate of the sprite frame on the sprite sheet. *)
    frame_width : float; (* Width of the sprite frame. *)
    frame_height : float; (* Height of the sprite frame. *)
  }

  type t = {
    sprite_sheet : Raylib.Texture.t; (* The sprite sheet texture. *)
    animations : (string, frame array * float array) Hashtbl.t;
        (* A hashtable mapping animation names to their frames and frame
           durations. *)
    scale : float; (* The scale at which to draw the sprite. *)
    mutable current_frame : int;
        (* The index of the current frame in the animation. *)
    mutable frame_timer : float;
        (* Timer to track the duration of the current frame. *)
    mutable current_animation : string;
        (* The name of the current animation being played. *)
  }

  val create :
    Raylib.Texture.t ->
    (string, frame array * float array) Hashtbl.t ->
    float ->
    t
  (** [create sprite_sheet animations scale] creates a new animated sprite with
      the given sprite_sheet, animations, and scale. *)

  val get_current_animation : t -> frame array * float array
  (** [get_current_animation t] returns the frames and their durations for the
      current animation. *)

  val update_frame_animation : t -> unit
  (** [update_frame_animation t] updates the sprite's current frame based on the
      frame timer and animation's duration. *)

  val switch_animation : t -> string -> unit
  (** [switch_animation t animation_name] switches the current animation of the
      sprite to the one specified by [animation_name]. *)

  val current_frame_index : t -> int
  (** [current_frame_index t] returns the index of the current frame in the
      current animation. *)

  val current_frame : t -> frame
  (** [current_frame t] returns the current frame of the animation. *)

  val get_src_x : t -> float
  (** [get_src_x t] returns the X-coordinate of the current frame on the sprite
      sheet. *)

  val get_src_y : t -> float
  (** [get_src_y t] returns the Y-coordinate of the current frame on the sprite
      sheet. *)

  val get_src_width : t -> float
  (** [get_src_width t] returns the width of the current frame. *)

  val get_spritesheet : t -> Raylib.Texture.t
  (** [get_spritesheet t] returns the sprite sheet texture used by the sprite. *)

  val get_src_height : t -> float
  (** [get_src_height t] returns the height of the current frame. *)

  val get_anim_name : t -> string
  (** [get_anim_name t] returns the name of the current animation. *)

  val src_rect : t -> Raylib.Rectangle.t
  (** [src_rect t] returns the source rectangle in the sprite sheet for the
      current frame. *)

  val dest_rect : t -> Raylib.Rectangle.t
  (** [dest_rect t] returns the destination rectangle where the current frame
      should be drawn on the screen. *)

  val is_animation_finished : t -> bool
  (** [is_animation_finished t] returns [true] if the current animation has
      finished playing, [false] otherwise. *)
end
