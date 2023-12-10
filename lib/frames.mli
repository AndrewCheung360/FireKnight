(** This module encapsulates the functionality for loading and organizing
    animation and sprite frame data for characters and HUD components. *)

type frame = Sprites.frame
(** The type representing a frame in a sprite animation. *)

(** This module provides functions for loading animation frame and sprite data
    from JSON files*)
module FrameDataLoader : sig
  val load_anim_frame_data : string -> string -> frame array * float array
  (** Loads animation frame data from a JSON file. Returns an array of frames
      and an array of corresponding durations.*)

  val load_frame_data : string -> string -> frame
  (** Loads a single frame's data from a JSON file.*)
end

(** module that contains animation frame data specific to a knight character.*)
module KnightFrames : sig
  val jsonfile : string
  (** JSON file path for knight frame data. *)

  val idle : frame array * float array
  (** idle animation frames and durations. *)

  val run : frame array * float array
  (** run animation frames and durations. *)

  val jump : frame array * float array
  (** jump animation frames and durations. *)

  val fall : frame array * float array
  (** fall animation frames and durations. *)

  val atk1 : frame array * float array
  (** attack 1 animation frames and durations. *)

  val atk2 : frame array * float array
  (** attack 2 animation frames and durations. *)

  val atk3 : frame array * float array
  (** attack 3 animation frames and durations. *)

  val ult : frame array * float array
  (** ultimate attack animation frames and durations. *)

  val hurt : frame array * float array
  (** hurt animation frames and durations. *)

  val death : frame array * float array
  (** death animation frames and durations. *)
end

(** Module that contains animation frame data specific to frost guardian.*)
module FrostGuardianFrames : sig
  val jsonfile : string
  (** JSON file path for frost guardian frame data. *)

  val idle : frame array * float array
  (** idle animation frames and durations. *)

  val hurt : frame array * float array
  (** run animation frames and durations. *)

  val punch : frame array * float array
  (** punch animation frames and durations. *)

  val intro : frame array * float array
  (** intro animation frames and durations. *)

  val death : frame array * float array
  (** death animation frames and durations. *)
end

(** Module that contains animation frame data specific to hud.*)
module HudFrames : sig
  val jsonfile : string
  (** JSON file path for hud frame data. *)

  val healthbar : frame
  (** healthbar frame data. *)

  val red_healthbar : frame
  (** red healthbar frame data. *)

  val manabar : frame
  (** manabar frame data *)

  val blue_manabar : frame
  (** blue manabar frame data *)

  val portrait_frame : frame
  (** character portrait frame data *)

  val gold_bar : frame
  (** gold bar frame data *)

  val menu : frame
  (** restart menu frame data *)
end
