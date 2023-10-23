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

  type t = state

  let loop_states = [ Idle; RunRight; RunLeft; Falling ]
  let is_loop_state state = List.mem state loop_states
end

module GuardianStates = struct
  type state =
    | Idle
    | Walk
    | Intro
    | Punch

  type t = state

  let loop_states = [ Idle; Walk ]
  let is_loop_state state = List.mem state loop_states
end
