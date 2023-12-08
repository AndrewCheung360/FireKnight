type frame = Sprites.frame

module FrameDataLoader = struct
  let load_anim_frame_data filepath anim_name =
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
          { Sprites.frame_x; frame_y; frame_width; frame_height })
        frames
    in
    let durations = List.map (fun duration -> duration |> to_float) durations in
    (Array.of_list frames, Array.of_list durations)

  let load_frame_data filepath name =
    let json = Yojson.Basic.from_file filepath in
    let open Yojson.Basic.Util in
    let frame = json |> member name in
    let frame_x = frame |> member "frame_x" |> to_float in
    let frame_y = frame |> member "frame_y" |> to_float in
    let frame_width = frame |> member "frame_width" |> to_float in
    let frame_height = frame |> member "frame_height" |> to_float in
    { Sprites.frame_x; frame_y; frame_width; frame_height }
end

module KnightFrames = struct
  let jsonfile = "data/knightframedata.json"
  let idle = FrameDataLoader.load_anim_frame_data jsonfile "idle"
  let run = FrameDataLoader.load_anim_frame_data jsonfile "run"
  let jump = FrameDataLoader.load_anim_frame_data jsonfile "jump"
  let fall = FrameDataLoader.load_anim_frame_data jsonfile "fall"
  let atk1 = FrameDataLoader.load_anim_frame_data jsonfile "atk1"
  let atk2 = FrameDataLoader.load_anim_frame_data jsonfile "atk2"
  let atk3 = FrameDataLoader.load_anim_frame_data jsonfile "atk3"
  let ult = FrameDataLoader.load_anim_frame_data jsonfile "ult_atk"
  let hurt = FrameDataLoader.load_anim_frame_data jsonfile "hurt"
  let death = FrameDataLoader.load_anim_frame_data jsonfile "death"
end

module FrostGuardianFrames = struct
  let jsonfile = "data/frostguardianframedata.json"
  let idle = FrameDataLoader.load_anim_frame_data jsonfile "idle"
  let hurt = FrameDataLoader.load_anim_frame_data jsonfile "hurt"
  let punch = FrameDataLoader.load_anim_frame_data jsonfile "punch"
  let intro = FrameDataLoader.load_anim_frame_data jsonfile "intro"

  let death =
    let reverse_array arr =
      Array.init (Array.length arr) (fun i -> arr.(Array.length arr - 1 - i))
    in
    let f, d = intro in
    (reverse_array f, reverse_array d)
end

module HudFrames = struct
  let jsonfile = "data/hudframedata.json"
  let healthbar = FrameDataLoader.load_frame_data jsonfile "healthbar"
  let red_healthbar = FrameDataLoader.load_frame_data jsonfile "red_healthbar"
  let manabar = FrameDataLoader.load_frame_data jsonfile "manabar"
  let blue_manabar = FrameDataLoader.load_frame_data jsonfile "blue_manabar"
  let portrait_frame = FrameDataLoader.load_frame_data jsonfile "portrait_frame"
  let gold_bar = FrameDataLoader.load_frame_data jsonfile "gold_bar"
  let menu = FrameDataLoader.load_frame_data jsonfile "menu"
end
