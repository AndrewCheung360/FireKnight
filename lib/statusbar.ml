module StatusBar = struct
  open Raylib

  type frame = {
    x : float;
    y : float;
    width : float;
    height : float;
  }

  type frame_dict = {
    healthbar : frame;
    manabar : frame;
  }

  type t = {
    sprite_sheet : Texture.t;
    health : int;
    mana : int;
    portrait : Texture.t;
    frames : frame_dict;
  }

  let create sprite_sheet health mana portrait =
    let frames =
      {
        healthbar = { x = 0.; y = 0.; width = 0.; height = 0. };
        manabar = { x = 0.; y = 0.; width = 0.; height = 0. };
      }
    in
    let t = { sprite_sheet; health; mana; portrait; frames } in
    t
end
