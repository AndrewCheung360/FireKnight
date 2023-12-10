(** This contains the Background module *)

(** The Background module handles the background rendering. *)
module Background : sig
  val ice_background_texture : Raylib.Texture.t option ref
  (** Reference to the ice background texture. *)

  val initialize : unit -> Raylib.Texture.t
  (** [initialize ()] loads, initializes, and returns the ice background
      texture. *)

  val draw_ice_background : Raylib.Texture.t -> unit
  (** [draw_ice_background texture] draws the ice background on the screen. *)
end
