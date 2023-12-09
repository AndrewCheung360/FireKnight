(**Test Plan: *)

open OUnit2
open Fireknight
open Constants
open Raylib
open Knight
open Sprites
open Frostguardian

let eq name expected_output actual_output =
  name >:: fun _ -> assert_equal expected_output actual_output

let state_test_k name exp act =
  eq name exp (States.KnightStates.is_loop_state act)

let state_test_g name exp act =
  eq name exp (States.GuardianStates.is_loop_state act)

let state_tests =
  [
    state_test_k "Knight is in loop state" true States.KnightStates.Falling;
    state_test_k "Knight is not in loop state" false
      States.KnightStates.Attack3Right;
    state_test_g "Guardian is in loop state" true States.GuardianStates.Idle;
    state_test_g "Guardian is not in loop state" false
      States.GuardianStates.Punch;
  ]

let setup () =
  init_window 1 1 "Test";
  set_target_fps 60;
  ( Knight.create_knight_animation (),
    FrostGuardian.create_frostguardian_animation (),
    Statusbar.StatusBar.create_statusbar () )

let knight, guardian, statusbar = setup ()

(* !: Beginning of Knight Helper Functions *)

let get_frame_height_test_k name exp anim =
  let _ = AnimatedSprite.switch_animation knight.animations anim in
  eq name exp (Knight.get_frame_height knight)

let get_frame_width_test_k name exp anim =
  let _ = AnimatedSprite.switch_animation knight.animations anim in
  eq name exp (Knight.get_frame_width knight)

let handle_jump_input_test_k name exp =
  eq name exp (Knight.handle_jump_input knight)

let handle_knight_anim_test name expected_animation animation =
  (* Printf.printf "Before %s, State: %s, Animation: %s\n" expected_animation
     (States.KnightStates.to_string knight.state) (AnimatedSprite.get_anim_name
     knight.animations); *)
  let _ = animation knight in

  (* Printf.printf "After %s, State: %s, Animation: %s\n" expected_animation
     (States.KnightStates.to_string knight.state) (AnimatedSprite.get_anim_name
     knight.animations); *)
  eq name expected_animation (AnimatedSprite.get_anim_name knight.animations)

(* !: End of Knight Helper Functions *)

(* !: Beginning of Frost Guardian Helper Functions *)
let get_frame_height_test_g name exp anim =
  let _ = AnimatedSprite.switch_animation guardian.animations anim in
  eq name exp (FrostGuardian.get_frame_height guardian)

let handle_death_anim_g name exp =
  let _ = FrostGuardian.handle_death guardian in
  eq name exp (AnimatedSprite.get_anim_name guardian.animations)

let handle_idle_anim_g name exp =
  let _ = FrostGuardian.handle_idle guardian in
  eq name exp (AnimatedSprite.get_anim_name guardian.animations)

let handle_punch_anim_g name exp =
  let _ = FrostGuardian.handle_punch guardian in
  eq name exp (AnimatedSprite.get_anim_name guardian.animations)
(* !: Beginning of Frost Guardian Helper Functions *)

let handle_knockback_test name exp init_x =
  let _ =
    knight.position <- Vector2.create init_x (Vector2.y knight.position);
    Knight.handle_knockback knight
  in
  eq name exp
    (Vector2.x knight.position, AnimatedSprite.get_anim_name knight.animations)

let mana_regen_test name exp m =
  let _ =
    knight.mana <- m;
    Knight.mana_regen knight
  in
  eq name exp knight.mana

let dec_health_test name exp n =
  let _ = Knight.dec_health guardian n in
  eq name exp guardian.health

(* !: Beginning of Sprite Helper Functions*)
let handle_get_test name exp get_name =
  let act = get_name statusbar.frames "healthbar" in
  eq name exp act

(* !: End of Sprite Helper Functions *)

let knight_tests =
  [
    get_frame_height_test_k "get_frame_height idle" 176. "idle";
    get_frame_width_test_k "get_frame_width idle" 240. "idle";
    get_frame_height_test_k "get_frame_height attack1" 164. "attack_1";
    get_frame_width_test_k "get_frame_width attack1" 204. "attack_1";
    handle_jump_input_test_k "handle_jump_input" States.KnightStates.Jump;
    mana_regen_test "mana_regen initial" 1000. 1000.;
    mana_regen_test "mana_regen 1" 999. 998.;
    dec_health_test "dec_health 1000"
      (Constants.guardian_max_health -. 1000.)
      1000.;
    handle_knight_anim_test "handle_death_anim knight" "death"
      Knight.handle_death;
    handle_knight_anim_test "handle_idle_anim knight" "idle" Knight.handle_idle;
    handle_knight_anim_test "handle_attack_1 sets correct animation" "attack_1"
      Knight.handle_attack_1;
    handle_knight_anim_test "handle_attack_2 sets correct animation" "attack_2"
      Knight.handle_attack_2;
    handle_knight_anim_test "handle_ultimate sets correct animation" "ult"
      Knight.handle_ultimate;
    handle_knight_anim_test "handle_run sets correct animation" "run"
      Knight.handle_run;
    handle_knockback_test "handle_knockback" (0., "hurt") (-15.);
  ]

let guardian_tests =
  [
    get_frame_height_test_g "get_frame_height idle" 506. "idle";
    get_frame_height_test_g "get_frame_height attack1" 82.5 "intro";
    handle_death_anim_g "handle_death_anim guard" "death";
    handle_idle_anim_g "handle_idle_anim guard" "idle";
    handle_punch_anim_g "handle_punch_anim guard" "punch";
  ]

let sprite_tests =
  [
    handle_get_test "handle_get_src_x testing" 135. Sprites.Sprite.get_src_x;
    handle_get_test "handle_get_src_y testing" 20. Sprites.Sprite.get_src_y;
    handle_get_test "handle_get_src_width testing" 52.
      Sprites.Sprite.get_src_width;
    handle_get_test "handle_get_src_height testing" 7.
      Sprites.Sprite.get_src_height;
  ]

let animated_sprite_tests = []

let suite =
  "FireKnight Suite"
  >::: List.flatten
         [
           state_tests;
           knight_tests;
           guardian_tests;
           sprite_tests;
           animated_sprite_tests;
         ]

let () = run_test_tt_main suite
