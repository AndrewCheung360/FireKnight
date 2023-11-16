(** The Background module handles the background rendering. *)
module Background :
  sig
    (** Reference to the ice background texture. *)
    val ice_background_texture : Raylib.Texture.t option ref

    (** [initialize ()] loads, initializes, and returns the ice background 
        texture. *)
    val initialize : unit -> Raylib.Texture.t

    (** [draw_ice_background texture] draws the ice background on the screen. *)
    val draw_ice_background : Raylib.Texture.t -> unit
  end
