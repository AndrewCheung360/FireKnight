(** This contains the Knight Module *)

(** This module defines the Knight character within the game. *)
module Knight : sig
  type t = {
    mutable position : Raylib.Vector2.t;
    mutable velocity : Raylib.Vector2.t;
    animations : Sprites.AnimatedSprite.t;
    mutable state : States.KnightStates.state;
    mutable attack_landed : bool;
    mutable hurt : bool;
    mutable health : float;
    mutable mana : float;
    mutable gold : int;
  }
  (** The type representing a Knight character *)

  val create_knight_animation : unit -> t
  (** Create and initialize the animations for a Knight character. *)

  val handle_idle : t -> unit
  (** Handle the idle state of the Knight. *)

  val vel_x : t -> float
  (** Retrieve the horizontal velocity of the Knight. *)

  val handle_velocity_x : t -> unit
  (** Handle the horizontal velocity of the Knight. *)

  val handle_position_x : t -> unit
  (** Handle the horizontal position of the Knight. *)

  val handle_run : t -> unit
  (** Handle the running animation and state of the Knight. *)

  val handle_velocity_y : t -> unit
  (** Handle the vertical velocity of the Knight. *)

  val handle_position_y : t -> unit
  (** Handle the vertical position of the Knight. *)

  val handle_jump : t -> unit
  (** Handle the jumping action of the Knight. *)

  val handle_fall : t -> unit
  (** Handle the falling action of the Knight. *)

  val apply_grav : t -> unit
  (** Apply gravitational force to the Knight. *)

  val handle_attack : t -> string -> unit
  (** Handle the Knight's attack based on a string identifier. *)

  val handle_attack_1 : t -> unit
  (** Handle the first attack sequence of the Knight. *)

  val handle_attack_2 : t -> unit
  (** Handle the second attack sequence of the Knight. *)

  val handle_attack_3 : t -> unit
  (** Handle the third attack sequence of the Knight. *)

  val handle_ultimate : t -> unit
  (** Handle the ultimate attack of the Knight. *)

  val handle_knockback : t -> unit
  (** Handle the knockback effect on the Knight. *)

  val handle_hurt : t -> unit
  (** Handle the hurt state of the Knight. *)

  val handle_death : t -> unit
  (** Handle the death state of the Knight. *)

  val handle_no_input : t -> States.KnightStates.state
  (** Handle the Knight's state when no input is received. *)

  val handle_jump_input : t -> States.KnightStates.state
  (** Handle the Knight's state when jump input is received. *)

  val handle_attack_input : t -> string -> States.KnightStates.state
  (** Handle the Knight's state based on attack input. *)

  val is_animation_finished : t -> bool
  (** Check if the current animation of the Knight is finished. *)

  val handle_key_input : t -> States.KnightStates.state
  (** Handle the Knight's key input and update its state. *)

  val handle_input : t -> unit
  (** Handle all inputs for the Knight. *)

  val set_dead_state : t -> unit
  (** Set the Knight to the dead state. *)

  val reset_atk_hurt : t -> unit
  (** Reset attack and hurt status of the Knight. *)

  val mana_regen : t -> unit
  (** Handle the mana regeneration of the Knight. *)

  val update : t -> unit
  (** Update the state and animation of the Knight. *)

  val get_frame_height : t -> float
  (** Get the height of the current animation frame of the Knight. *)

  val get_frame_width : t -> float
  (** Get the width of the current animation frame of the Knight. *)

  val draw_pos : t -> float * Raylib.Vector2.t
  (** Get the drawing position for the Knight. *)

  val hurt_box : t -> Raylib.Rectangle.t
  (** Define the hurt box for the Knight. *)

  val hit_box_helper : float -> float -> int -> int -> t -> Raylib.Rectangle.t
  (** Helper function to calculate the hit box of the Knight. *)

  val hit_box : t -> Raylib.Rectangle.t option
  (** Get the hit box of the Knight, if applicable. *)

  val dec_health : Frostguardian.FrostGuardian.t -> float -> unit
  (** Decrease the health of the Knight when hit by the FrostGuardian. *)

  val inc_gold : t -> int -> unit
  (** Increase the gold count of the Knight. *)

  val handle_gold_health :
    t -> Frostguardian.FrostGuardian.t -> int -> float -> unit
  (** Handle the gold and health interaction between the Knight and
      FrostGuardian. *)

  val apply_damage : t -> Frostguardian.FrostGuardian.t -> unit
  (** Apply damage to the Knight from the FrostGuardian. *)

  val draw_debug : t -> unit
  (** Draw the debug information for the Knight. *)

  val draw : t -> unit
  (** Draw the Knight character. *)
end
