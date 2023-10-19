module StateManager = struct
  type state =
    | Idle
    | RunRight
    | RunLeft
    | Attack1Right

  type t = state

  (* let handle_key_input () = if is_key_pressed Key.J then Attack1Right else if
     is_key_down Key.D then RunRight else if is_key_down Key.A then RunLeft else
     Idle *)
end
