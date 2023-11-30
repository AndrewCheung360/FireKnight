open Raylib

(** The Knight module defines the behavior, attributes, and animation of the
    playable fire knight character *)
module Knight : sig
  type t = {
    mutable position : Raylib.Vector2.t;
    mutable velocity : Raylib.Vector2.t;
    animations : Sprites.AnimatedSprite.t;
    mutable state : States.KnightStates.state;
  }
  (** The type representing the knight character. *)

  val create_knight_animation : unit -> t
  (** [create_knight_animation ()] creates a new knight instance with default
      attributes *)

  val handle_idle : t -> unit
  (** [handle_idle knight] handles the knight's behavior when in the idle state. *)

  val handle_run : t -> unit
  (** [handle_run knight] handles the knight's behavior when in the run state.*)

  val handle_attack_1 : t -> unit
  (** [handle_attack_1 knight] handles the knight's behavior when performing the
      first attack. *)

  val handle_attack_2 : t -> unit
  (** [handle_attack_2 knight] handles the knight's behavior when performing the
      second attack. *)

  val handle_jump : t -> unit
  (** [handle_jump knight] handles the knight's behavior when jumping. *)

  val handle_fall : t -> unit
  (** [handle_fall knight] handles the knight's behavior when falling. *)

  val apply_grav : t -> unit
  (** [apply_grav knight] applies gravity to the knight, affecting its velocity. *)

  val handle_attack_3 : t -> unit
  (** [handle_attack_3 knight] handles the knight's behavior when performing the
      third attack. *)

  val handle_ultimate : t -> unit
  (** [handle_ultimate knight] handles the knight's behavior when using the
      ultimate attack. *)

  val handle_key_input : t -> States.KnightStates.state
  (** [handle_key_input knight] handles and returns the knight's state based on
      user keyboard input. *)

  val handle_input : t -> unit
  (** [handle_input knight] handles the overall input and behavior of the
      knight. *)

  val update : t -> unit
  (** [update knight] updates the knight's position, velocity, and animations. *)

  val hurt_box : t -> Rectangle.t
  (** [hurt_box knight] updates and returns the knight's hurtbox *)

  val draw : t -> unit
  (** [draw knight] draws the knight on the screen with the current animation
      frame. *)
end
