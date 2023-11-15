(** The FrostGuardian module defines the behavior and attributes of the frost 
    guardian boss character. *)
module FrostGuardian :
  sig

    (** The type representing the frost guardian character. *)
    type t = {
      mutable position : Raylib.Vector2.t;     
      mutable velocity : Raylib.Vector2.t;       
      animations : Sprites.AnimatedSprite.t;      
      mutable state : States.GuardianStates.state;
    }

    (** [create_frostguardian_animation ()] creates a new frost guardian 
    instance with default attributes and returns it. *)
    val create_frostguardian_animation : unit -> t

    (** [handle_idle guardian] handles the frost guardian's behavior when in the 
        idle state. *)
    val handle_idle : t -> unit

    (** [handle_intro guardian] handles the frost guardian's behavior during the 
        intro state. *)
    val handle_intro : t -> unit

    (** [handle_state guardian] handles the overall behavior of the frost 
        guardian based on its current state. *)
    val handle_state : t -> unit

    (** [update guardian] updates the frost guardian's position, velocity, and 
        animations. *)
    val update : t -> unit

    (** [draw guardian] draws the frost guardian on the screen with the 
        current animation frame. *)
    val draw : t -> unit
  end
