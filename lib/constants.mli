(** This contains the Constants Module *)

(** This module defines constants used throughout the game *)
module Constants : sig
  (** The different states the game can be in. *)
  type game_state =
    | Playing
    | Win
    | GameOver

  val screen_width : int
  (** The width of the game screen in pixels. *)

  val screen_height : int
  (** The height of the game screen in pixels. *)

  val fps : int
  (** Frames per second the game should run at. *)

  val max_vel_x : float
  (** Maximum horizontal velocity of a character or object. *)

  val max_vel_y : float
  (** Maximum vertical velocity of a character or object. *)

  val accel_x : float
  (** Horizontal acceleration of a character or object. *)

  val ground_y : float
  (** The y-coordinate representing the ground level in the game. *)

  val left_boundary : float
  (** The x-coordinate representing the left boundary of the game world. *)

  val upper_boundary : float
  (** The y-coordinate representing the upper boundary of the game world. *)

  val right_boundary : float
  (** The x-coordinate representing the right boundary of the game world. *)

  val knight_scale : float
  (** Scaling factor for the knight character. *)

  val frost_guardian_scale : float
  (** Scaling factor for the frost guardian character. *)

  val grav : float
  (** Gravitational acceleration in the game world. *)

  val jump_force : float
  (** Force exerted when a character jumps. *)

  val debug : bool
  (** Flag for enabling debug mode. *)

  val guardian_max_health : float
  (** Maximum health of the guardian character. *)

  val max_health : float
  (** Maximum health of the player character. *)

  val max_mana : float
  (** Maximum mana of the player character. *)
end
