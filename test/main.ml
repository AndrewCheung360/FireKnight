(**Test Plan: *)

open OUnit2
open Fireknight
open Constants
open Raylib
open Knight
open Sprites

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

let knight_setup () =
  init_window 1 1 "Test";
  set_target_fps 60;
  Knight.create_knight_animation ()

let knight = knight_setup ()

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

let get_frame_height_test name exp =
  eq name exp (Knight.get_frame_height knight)

let handle_jump_input_test name exp =
  eq name exp (Knight.handle_jump_input knight)

let handle_death_anim name exp =
  let _ = Knight.handle_death knight in
  eq name exp (AnimatedSprite.get_anim_name knight.animations)

let handle_idle_anim name exp =
  let _ = Knight.handle_idle knight in
  eq name exp (AnimatedSprite.get_anim_name knight.animations)

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
    get_frame_height_test "get_frame_height idle" 176.;
    handle_jump_input_test "handle_jump_input" States.KnightStates.Jump;
    handle_death_anim "handle_death_anim" "death";
    handle_idle_anim "handle_idle_anim" "idle";
  ]

let suite = "FireKnight Suite" >::: List.flatten [ state_tests; knight_tests ]
let () = run_test_tt_main suite
