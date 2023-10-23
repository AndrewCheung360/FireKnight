module FrameDataLoader = struct
  type frame = Sprites.AnimatedSprite.frame

  (**load_frame_data should read the json file from filepath and based on anim
     name extract the frame data and durations into a tuple*)
  let load_frame_data filepath anim_name =
    let json = Yojson.Basic.from_file filepath in
    let open Yojson.Basic.Util in
    let frames = json |> member anim_name |> member "frames" |> to_list in
    let durations = json |> member anim_name |> member "durations" |> to_list in
    let frames =
      List.map
        (fun frame ->
          let frame_x = frame |> member "frame_x" |> to_float in
          let frame_y = frame |> member "frame_y" |> to_float in
          let frame_width = frame |> member "frame_width" |> to_float in
          let frame_height = frame |> member "frame_height" |> to_float in
          { Sprites.AnimatedSprite.frame_x; frame_y; frame_width; frame_height })
        frames
    in
    let durations = List.map (fun duration -> duration |> to_float) durations in
    (Array.of_list frames, Array.of_list durations)
end

module KnightFrames = struct
  type frame = Sprites.AnimatedSprite.frame

  let jsonfile = "data/knightframedata.json"
  let idle = FrameDataLoader.load_frame_data jsonfile "idle"
  let run = FrameDataLoader.load_frame_data jsonfile "run"
  let atk1 = FrameDataLoader.load_frame_data jsonfile "atk1"
  let atk2 = FrameDataLoader.load_frame_data jsonfile "atk2"
  let atk3 = FrameDataLoader.load_frame_data jsonfile "atk3"
  let ult = FrameDataLoader.load_frame_data jsonfile "ult_atk"
end
