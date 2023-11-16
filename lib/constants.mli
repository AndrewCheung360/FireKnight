(** Constants related to the game *)
module Constants : sig
  (** Width of the game screen *)
  val screen_width : int
  (** Height of the game screen *)
  val screen_height : int
  (** Frames per second for the game *)
  val fps : int
  (** Maximum x-velocity for the knight*)
  val max_vel_x : float
  (** Maximum jumping/falling velocity for the knight*)
  val max_vel_y : float
  (** Constant to cause windup in any horizontal input direction*)
  val accel_x : float
  (** Pixel of the floor*)
  val ground_y : float
  (**Left most x-position of the knight*)
  val left_boundary : float
  (**Top most y-position of the knight*)
  val upper_boundary : float
  (**Right most x-position of the knight*)
  val right_boundary : float
  (**Scaling factor for the sprite of the knight*)
  val knight_scale : float
  (**Scaling factor for the sprite of the boss*)
  val frost_guardian_scale : float
  (** Gravity constant applied to y-velocity of the knight*)
  val grav : float
  (** Initial velocity in the upwards y-direction upon jumping*)
  val jump_force : float
end
