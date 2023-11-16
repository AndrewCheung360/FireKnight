(** The KnightStates module defines the various states of the Fire Knight Sprite
    in a game. It includes distinct states that the Fire Knight can be in during
    the game's progression. *)
module KnightStates : sig
  type state =
    | Idle (* The state where the Fire Knight is not in motion or action. *)
    | RunRight
      (* The state where the Fire Knight is running towards the right
         direction. *)
    | RunLeft
      (* The state where the Fire Knight is running towards the left
         direction. *)
    | Attack1Right
      (* The state representing the first attack move in the right direction. *)
    | Attack2Right
      (* The state representing the second attack move in the right
         direction. *)
    | Jump (* The state where the Fire Knight is jumping. *)
    | Falling
      (* The state where the Fire Knight is falling down, typically after a
         jump. *)
    | Attack3Right
      (* The state representing the third attack move in the right direction. *)
    | UltimateRight
  (* The state representing a special or ultimate move in the right
     direction. *)

  type t = state
  (** The representation type for the state of the Fire Knight. *)

  val loop_states : state list
  (** [loop_states] is a list of all the different states that can loop (repeat)
      in the game. For instance, Idle, RunRight, and RunLeft states can be
      looped. *)

  val is_loop_state : state -> bool
  (** [is_loop_state state] checks if the given [state] is one of the looping
      states. It returns [true] if the state can loop, and [false] otherwise. *)
end

(** The GuardianStates module defines the various states of the Frost Guardian
    Sprite in a game. This module outlines distinct states for this character,
    similar to the KnightStates module. *)
module GuardianStates : sig
  type state =
    | Idle
      (* The state where the Frost Guardian is stationary, not engaged in any
         action. *)
    | Walk (* The state where the Frost Guardian is walking. *)
    | Intro (* The state representing an introductory or entrance animation. *)
    | Punch
  (* The state where the Frost Guardian is executing a punch action. *)

  type t = state
  (** The representation type for the state of the Frost Guardian. *)

  val loop_states : state list
  (** [loop_states] is a list of all the different states that can loop (repeat)
      for the Frost Guardian. States like Idle and Walk are typically included
      in this list. *)

  val is_loop_state : state -> bool
  (** [is_loop_state state] checks if the given [state] is a looping state for
      the Frost Guardian. It returns [true] if the state can loop, and [false]
      otherwise. *)
end
