(** This contains the FrostGuardian Module *)

(** This module defines the FrostGuardian character in the game. *)
module FrostGuardian : sig
  type t = {
    mutable position : Raylib.Vector2.t;
    mutable velocity : Raylib.Vector2.t;
    animations : Sprites.AnimatedSprite.t;
    mutable state : States.GuardianStates.state;
    mutable idlecounter : int;
    mutable attack_landed : bool;
    mutable hurt : bool;
    mutable health : float;
  }
  (** The type representing a FrostGuardian *)

  val create_frostguardian_animation : unit -> t
  (** Create and initialize the animations for a FrostGuardian character. *)

  val is_animation_finished : t -> bool
  (** Check if the current animation of the FrostGuardian is finished. *)

  val start_punch : t -> unit
  (** Start the punch animation for the FrostGuardian. *)

  val handle_idle : t -> unit
  (** Handle the idle state of the FrostGuardian. *)

  val handle_punch_pos : t -> unit
  (** Handle the position during the punch animation of the FrostGuardian. *)

  val handle_punch : t -> unit
  (** Handle the punch action of the FrostGuardian. *)

  val handle_intro : t -> unit
  (** Handle the intro animation or state of the FrostGuardian. *)

  val handle_death : t -> unit
  (** Handle the death animation or state of the FrostGuardian. *)

  val handle_hurt : t -> unit
  (** Handle the hurt state of the FrostGuardian. *)

  val handle_state : t -> unit
  (** Handle the general state logic of the FrostGuardian. *)

  val reset_atk_hurt : t -> unit
  (** Reset attack and hurt status of the FrostGuardian. *)

  val set_hurt_state : t -> unit
  (** Set the FrostGuardian to the hurt state. *)

  val set_dead_state : t -> unit
  (** Set the FrostGuardian to the dead state. *)

  val update : t -> unit
  (** Update the state and animation of the FrostGuardian. *)

  val get_frame_height : t -> float
  (** Get the height of the current animation frame of the FrostGuardian. *)

  val get_drawing_pos : t -> Raylib.Vector2.t
  (** Get the position for drawing the FrostGuardian. *)

  val hurt_box : t -> Raylib.Rectangle.t
  (** Define the hurt box for the FrostGuardian. *)

  val hit_box_helper : float -> float -> int -> int -> t -> Raylib.Rectangle.t
  (** Helper function to calculate the hit box of the FrostGuardian. *)

  val hit_box : t -> Raylib.Rectangle.t option
  (** Get the hit box of the FrostGuardian, if applicable. *)

  val draw_debug : t -> unit
  (** Draw the debug information for the FrostGuardian. *)

  val draw : t -> unit
  (** Draw the FrostGuardian character. *)
end
