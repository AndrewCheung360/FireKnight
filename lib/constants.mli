module Constants : sig
  (** Constants related to the game *)

  val screen_width : int
  (** Width of the game screen *)

  val screen_height : int
  (** Height of the game screen *)

  val fps : int
  (** Frames per second for the game *)

  val max_vel_x : float
  (** Maximum x-velocity for the knight*)

  val max_vel_y : float
  (** Maximum jumping/falling velocity for the knight*)

  val accel_x : float
  (** Constant to cause windup in any horizontal input direction*)

  val ground_y : float
  (** Pixel of the floor*)

  val left_boundary : float
  (**Left most x-position of the knight*)

  val upper_boundary : float
  (**Top most y-position of the knight*)

  val right_boundary : float
  (**Right most x-position of the knight*)

  val knight_scale : float
  (**Scaling factor for the sprite of the knight*)

  val frost_guardian_scale : float
  (**Scaling factor for the sprite of the boss*)

  val grav : float
  (** Gravity constant applied to y-velocity of the knight*)

  val jump_force : float
  (** Initial velocity in the upwards y-direction upon jumping*)
end
