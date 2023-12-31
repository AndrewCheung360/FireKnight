module Constants = struct
  type game_state =
    | Playing
    | Win
    | GameOver

  let screen_width = 1500
  let screen_height = 900
  let fps = 60
  let max_vel_x = 8.0
  let max_vel_y = 12.0
  let accel_x = 1.25
  let ground_y = -725.
  let left_boundary = 0.
  let upper_boundary = 0.
  let right_boundary = -1260.
  let knight_scale = 4.0
  let frost_guardian_scale = 5.5
  let grav = -0.98
  let jump_force = 18.
  let debug = false
  let guardian_max_health = 5000.
  let max_health = 1000.
  let max_mana = 1000.
end
