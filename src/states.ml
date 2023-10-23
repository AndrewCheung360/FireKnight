module StateManager = struct
  type state =
    | Idle
    | RunRight
    | RunLeft
    | Attack1Right
    | Attack2Right
    | Jump
    | Falling

  type t = state

  let loop_states = [ Idle; RunRight; RunLeft; Falling ]
  let is_loop_state state = List.mem state loop_states

  (* let handle_key_input () = if is_key_pressed Key.J then Attack1Right else if
     is_key_down Key.D then RunRight else if is_key_down Key.A then RunLeft else
     Idle *)
end
