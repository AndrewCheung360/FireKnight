module StateManager = struct
  type state =
    | Idle
    | RunRight
    | RunLeft
    | Attack1Right
    | Attack2Right
    | Attack3Right
    | UltimateRight

  type t = state

  let loop_states = [ Idle; RunRight; RunLeft ]
  let is_loop_state state = List.mem state loop_states
end
