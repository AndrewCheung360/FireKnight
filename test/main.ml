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
    FrostGuardian.create_frostguardian_animation () )

let knight = fst (setup ())
let guardian = snd (setup ())

let create_knight_animation_test name exp =
  eq name exp
    ( Vector2.x knight.position,
      Vector2.y knight.position,
      Vector2.x knight.velocity,
      Vector2.y knight.velocity,
      knight.state,
      knight.attack_landed,
      knight.hurt,
      knight.health,
      knight.mana,
      knight.gold )

let get_frame_height_test_k name exp anim =
  let _ = AnimatedSprite.switch_animation knight.animations anim in
  eq name exp (Knight.get_frame_height knight)

let get_frame_width_test_k name exp anim =
  let _ = AnimatedSprite.switch_animation knight.animations anim in
  eq name exp (Knight.get_frame_width knight)

let get_frame_height_test_g name exp anim =
  let _ = AnimatedSprite.switch_animation guardian.animations anim in
  eq name exp (FrostGuardian.get_frame_height guardian)

let handle_jump_input_test_k name exp =
  eq name exp (Knight.handle_jump_input knight)

let handle_death_anim_k name exp =
  let _ = Knight.handle_death knight in
  eq name exp (AnimatedSprite.get_anim_name knight.animations)

let handle_idle_anim_k name exp =
  let _ = Knight.handle_idle knight in
  eq name exp (AnimatedSprite.get_anim_name knight.animations)

let mana_regen_test name exp m =
  let _ =
    knight.mana <- m;
    Knight.mana_regen knight
  in
  eq name exp knight.mana

let dec_health_test name exp n =
  let _ = Knight.dec_health guardian n in
  eq name exp guardian.health

let handle_attack_test name expected_animation attack =
  Printf.printf "Before handle_attack_1, State: %s, Animation: %s\n"
    (States.KnightStates.to_string knight.state)
    (AnimatedSprite.get_anim_name knight.animations);

  let _ = attack knight in

  Printf.printf "After handle_attack_1, State: %s, Animation: %s\n"
    (States.KnightStates.to_string knight.state)
    (AnimatedSprite.get_anim_name knight.animations);

  eq name expected_animation (AnimatedSprite.get_anim_name knight.animations)

let knight_tests =
  [
    create_knight_animation_test "create_knight_animation"
      ( 0.,
        Constants.ground_y,
        0.,
        0.,
        States.KnightStates.Idle,
        false,
        false,
        Constants.max_health,
        Constants.max_mana,
        0 );
    get_frame_height_test_k "get_frame_height idle" 176. "idle";
    get_frame_width_test_k "get_frame_width idle" 240. "idle";
    get_frame_height_test_k "get_frame_height attack1" 164. "attack_1";
    get_frame_width_test_k "get_frame_width attack1" 204. "attack_1";
    handle_jump_input_test_k "handle_jump_input" States.KnightStates.Jump;
    handle_death_anim_k "handle_death_anim" "death";
    handle_idle_anim_k "handle_idle_anim" "idle";
    mana_regen_test "mana_regen initial" 1000. 1000.;
    mana_regen_test "mana_regen 1" 999. 998.;
    dec_health_test "dec_health 1000"
      (Constants.guardian_max_health -. 1000.)
      1000.;
  ]

let guardian_tests =
  [
    get_frame_height_test_g "get_frame_height idle" 506. "idle";
    get_frame_height_test_g "get_frame_height attack1" 82.5 "intro";
    handle_attack_test "handle_attack_1 sets correct animation" "attack_1"
      Knight.handle_attack_1;
    handle_attack_test "handle_attack_2 sets correct animation" "attack_2"
      Knight.handle_attack_2;
    handle_attack_test "handle_ultimate sets correct animation" "ult"
      Knight.handle_ultimate;
  ]

let sprite_tests = []
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
