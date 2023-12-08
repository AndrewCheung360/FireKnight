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
end
