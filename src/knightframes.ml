module Knightframes = struct
  open Animatedsprite

  type frame = Animatedsprite.frame

  let idle =
    ( [|
        {
          Animatedsprite.frame_x = 100.;
          frame_y = 83.;
          frame_width = 60.;
          frame_height = 44.;
        };
        { frame_x = 388.; frame_y = 83.; frame_width = 60.; frame_height = 44. };
        { frame_x = 676.; frame_y = 83.; frame_width = 60.; frame_height = 44. };
        { frame_x = 964.; frame_y = 83.; frame_width = 60.; frame_height = 44. };
        {
          frame_x = 1252.;
          frame_y = 83.;
          frame_width = 60.;
          frame_height = 44.;
        };
        {
          frame_x = 1540.;
          frame_y = 84.;
          frame_width = 60.;
          frame_height = 43.;
        };
        {
          frame_x = 1828.;
          frame_y = 84.;
          frame_width = 60.;
          frame_height = 43.;
        };
        {
          frame_x = 2116.;
          frame_y = 84.;
          frame_width = 60.;
          frame_height = 43.;
        };
      |],
      [| 0.15; 0.15; 0.15; 0.15; 0.15; 0.15; 0.15; 0.15 |] )
end
