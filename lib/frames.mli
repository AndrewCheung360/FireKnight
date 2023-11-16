module FrameDataLoader : sig
  (** Loading in frame data from a json file and create a sprite *)

  type frame = Sprites.AnimatedSprite.frame
  (** Raylib type for frame data. *)

  val load_frame_data :
    string -> string -> Sprites.AnimatedSprite.frame array * float array
  (**load_frame_data should read the json file from filepath and based on anim
     name extract the frame data and durations into a tuple*)
end

module KnightFrames : sig
  (** Frame data of the knight *)

  type frame = FrameDataLoader.frame
  (** Representation type of the frame data. *)

  val jsonfile : string
  (** [jsonfile] Directory of the jsonfile containing frame data for the knight. *)

  val idle : FrameDataLoader.frame array * float array
  (** [idle] Frames and durations for the idle animation of the knight. *)

  val run : FrameDataLoader.frame array * float array
  (** [run] Frames and durations for the jumping animation of the knight. *)

  val jump : FrameDataLoader.frame array * float array
  (** [jump] Frames and durations for the jumping animation of the knight. *)

  val fall : FrameDataLoader.frame array * float array
  (** [fall] Frames and durations for the falling animation of the knight. *)

  val atk1 : FrameDataLoader.frame array * float array
  (** [atk1] Frames and durations for the first attack animation of the knight. *)

  val atk2 : FrameDataLoader.frame array * float array
  (** [atk2] Frames and durations for the second attack animation of the knight. *)

  val atk3 : FrameDataLoader.frame array * float array
  (** [atk3] Frames and durations for the third attack animation of the knight. *)

  val ult : FrameDataLoader.frame array * float array
  (** [ult] Frames and durations for the ultimate attack animation of the
      knight. *)
end

module FrostGuardianFrames : sig
  (** Frame data of the Frost Guardian *)

  type frame = FrameDataLoader.frame
  (** Representation type of the frame data. *)

  val jsonfile : string
  (** [jsonfile] Directory of the jsonfile containing frame data for the frost
      guardian. *)

  val idle : FrameDataLoader.frame array * float array
  (** [idle] Frames and durations for the idle animation of the frost guardian. *)

  val walk : FrameDataLoader.frame array * float array
  (** [walk] Frames and durations for the walking animation of the frost
      guardian. *)

  val punch : FrameDataLoader.frame array * float array
  (** [punch] Frames and durations for the punching animation of the frost
      guardian. *)

  val intro : FrameDataLoader.frame array * float array
  (** [intro] Frames and durations for the intro animation of the frost
      guardian. *)
end
