module StateManager = struct
  open Raylib

  type state =
    | Idle
    | RunRight
    | RunLeft

  type t = state

  let handle_key_input () =
    if is_key_down Key.D then RunRight
    else if is_key_down Key.A then RunLeft
    else Idle
end
