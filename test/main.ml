open OUnit2

(********************************************************************
   Here are some helper functions for your testing of bag-like lists.
 ********************************************************************)

(********************************************************************
   End helper functions.
 ********************************************************************)

let all_tests = []
let suite = "test suite for Fire-Knigt" >::: List.flatten [ all_tests ]
let () = run_test_tt_main suite
