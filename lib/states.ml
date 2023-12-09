module KnightStates = struct
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

  let loop_states = [ Idle; RunRight; RunLeft; Falling ]
  let is_loop_state state = List.mem state loop_states

  let to_string = function
    | Idle -> "Idle"
    | RunRight -> "RunRight"
    | RunLeft -> "RunLeft"
    | Attack1Right -> "Attack1Right"
    | Attack2Right -> "Attack2Right"
    | Jump -> "Jump"
    | Falling -> "Falling"
    | Attack3Right -> "Attack3Right"
    | UltimateRight -> "UltimateRight"
    | Hurt -> "Hurt"
    | Death -> "Death"
end

module GuardianStates = struct
  type state =
    | Idle
    | Hurt
    | Intro
    | Punch
    | Death

  type t = state

  let loop_states = [ Idle ]
  let is_loop_state state = List.mem state loop_states

  let to_string = function
    | Idle -> "Idle"
    | Hurt -> "Hurt"
    | Intro -> "Intro"
    | Punch -> "Punch"
    | Death -> "Death "
end
