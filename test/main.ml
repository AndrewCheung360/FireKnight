open OUnit2
(**Test Plan: *)

let all_tests = []
let suite = "test suite for Fire-Knight" >::: List.flatten [ all_tests ]
let () = run_test_tt_main suite
