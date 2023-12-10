(** This contains the StatusBar module *)

(** This module defines the StatusBars, like health and mana, in the game. *)
module StatusBar : sig
  type t = {
    sprite_sheet : Raylib.Texture.t;
    health : int;
    mana : int;
    portrait : Raylib.Texture.t;
    frames : Sprites.Sprite.t;
  }
  (** The type representing a StatusBar for displaying game status information. *)

  val create_statusbar : unit -> t
  (** Create a new StatusBar instance. *)

  val draw_helper : t -> string -> float -> float -> unit
  (** Helper function to draw parts of the status bar. *)

  val draw_restart_screen : t -> int -> unit
  (** Draw the screen that appears when restarting the game. *)

  val draw_boss_healthbar : t -> float -> unit
  (** Draw the health bar for the boss character. *)

  val draw_red_healthbar : t -> float -> unit
  (** Draw the red health bar for the player character. *)

  val draw_gold : int -> unit
  (** Draw the gold count. *)

  val draw_blue_manabar : t -> float -> unit
  (** Draw the blue mana bar for the player character. *)

  val draw_portrait : t -> unit
  (** Draw the portrait of the player character. *)

  val draw_manabar : t -> unit
  (** Draw the mana bar for the player character. *)

  val draw_healthbar : t -> unit
  (** Draw the health bar for the player character. *)

  val draw_goldbar : t -> unit
  (** Draw the gold bar indicating the player's gold count. *)

  val draw : t -> unit
  (** Draw the entire status bar with all its components. *)
end
