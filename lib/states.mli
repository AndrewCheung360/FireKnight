(** THis module defines the different states of both the Knight and the Frost
    Guardian *)

(** This module defines the various states the Knight can be in during the game. *)
module KnightStates : sig
  (** Enumeration of possible states for the Knight character. *)
  type state =
    | Idle
    | RunRight
    | RunLeft
    | Attack1Right
    | Attack2Right
    | Jump
    | Falling
    | Attack3Right
    | UltimateRight
    | Hurt
    | Death

  type t = state
  (** Alias for the state type. *)

  val loop_states : state list
  (** List of states that can loop during animation. *)

  val is_loop_state : state -> bool
  (** Determines if a given state is one that loops during animation. *)

  val to_string : state -> string
  (** Convert a state to its string representation. *)
end

(** This module defines the various states a Guardian can be in during the game. *)
module GuardianStates : sig
  (** Enumeration of possible states for the Guardian character. *)
  type state =
    | Idle  (** The Guardian is idle. *)
    | Hurt  (** The Guardian is in a hurt state. *)
    | Intro  (** The Guardian is in an introductory state. *)
    | Punch  (** The Guardian is performing a punch action. *)
    | Death  (** The Guardian is in a death state. *)

  type t = state
  (** Alias for the state type. *)

  val loop_states : state list
  (** List of states that can loop during animation. *)

  val is_loop_state : state -> bool
  (** Determines if a given state is one that loops during animation. *)

  val to_string : state -> string
  (** Convert a state to its string representation. *)
end
