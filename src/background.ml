module Background = struct
  open Raylib

  let ice_background_texture = ref None

  let initialize () =
    ice_background_texture :=
      Some (load_texture "assets/background/ice_background.png");
    match !ice_background_texture with
    | Some tex -> tex
    | None -> failwith "Failed to load background texture"

  let draw_ice_background texture =
    let src_rectangle = Rectangle.create 0. 0. 1920. 1080. in
    let dest_rectangle = Rectangle.create 0. 0. 1200. 800. in
    let origin = Vector2.create 0. 0. in
    draw_texture_pro texture src_rectangle dest_rectangle origin 0.
      Color.raywhite
end
