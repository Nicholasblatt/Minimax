; Nicholas Blatt
; Implementation of MINIMAX-DECISION - 4x4 Tic-Tac-Toe
;
;		How to run the game in terminal:
;
;				clisp hw05c.lisp
;
;
;		Player = X
;		Computer = O
;
;		How to play:
;
;			 c o l u m n s
;				 1  2  3  4
; 	r	 1[_][_][_][_]
;		o	 2[_][_][_][_]
;		w	 3[_][_][_][_]
;		s	 4[_][_][_][_]
;
;
;		Enter the pairwise position where you wish to place
;		an X. For example, if you want to place an X at position
;		(row 1, column 3) you would enter 13. If you want to place
;		an X at position (row 4, column 2) you would enter 42.
;


; Generates a blank 4x4 gameboard. Implemented as 1-D array.
; 	Blanks are [_]
;		O's are [O]
;		X's are [X]
(defun generate-gameboard()
	(setf gameboard (make-array '(16)))
	(dotimes (index 16)
		(setf (aref gameboard index) '[_])
	)
	(return-from generate-gameboard gameboard)
)

; Iterates through array, displaying 4 rows and 4 columns of spaces.
;		For example:
;				c1 c2 c3 c4
;			r1[_][_][_][_]
;			r2[_][_][_][_]
;			r3[_][_][_][_]
;			r4[_][_][_][_]
(defun display-gameboard(gameboard)
	(terpri)
	(loop for index from 0 to 3
		do (write (aref gameboard index))
	)
	(terpri)
	(loop for index from 4 to 7
		do (write (aref gameboard index))
	)
	(terpri)
	(loop for index from 8 to 11
		do (write (aref gameboard index))
	)
	(terpri)
	(loop for index from 12 to 15
		do (write (aref gameboard index))
	)
)

; Player moves are encoded as pairwise values,
; and the corresponding gameboard index is calculated.
; Takes an X move and places it on the real gameboard.
(defun x-turn (gameboard move)
	(X-RESULT gameboard 
		(+ 
			(* (- (floor move 10) 1) 4) 
			(- (mod move 10) 1)
		)
	)
)

; Computer moves are simply gameboard indices (0 - 15).
; Takes an O move and places it on the real gameboard.
(defun o-turn (gameboard move)
	(setf (aref gameboard move) '[O])
)

; Terminal test
;		- 24 ways to line up 3-in-a-row X's for player to win.
; 	- 24 ways to line up 3-in-a-row O's for computer to win.
;		- Any state that has no winner and no more valid moves is a tie.
(defun TERMINAL-TEST(state)
	(if (string= (aref state 0) '[X])
		(if (string= (aref state 1) '[X])
			(if (string= (aref state 2) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 1) '[X])
		(if (string= (aref state 2) '[X])
			(if (string= (aref state 3) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 4) '[X])
		(if (string= (aref state 5) '[X])
			(if (string= (aref state 6) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 5) '[X])
		(if (string= (aref state 6) '[X])
			(if (string= (aref state 7) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 8) '[X])
		(if (string= (aref state 9) '[X])
			(if (string= (aref state 10) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 9) '[X])
		(if (string= (aref state 10) '[X])
			(if (string= (aref state 11) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 12) '[X])
		(if (string= (aref state 13) '[X])
			(if (string= (aref state 14) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 13) '[X])
		(if (string= (aref state 14) '[X])
			(if (string= (aref state 15) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 0) '[X])
		(if (string= (aref state 4) '[X])
			(if (string= (aref state 8) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 4) '[X])
		(if (string= (aref state 8) '[X])
			(if (string= (aref state 12) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 1) '[X])
		(if (string= (aref state 5) '[X])
			(if (string= (aref state 9) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 5) '[X])
		(if (string= (aref state 9) '[X])
			(if (string= (aref state 13) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 2) '[X])
		(if (string= (aref state 6) '[X])
			(if (string= (aref state 10) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 6) '[X])
		(if (string= (aref state 10) '[X])
			(if (string= (aref state 14) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 3) '[X])
		(if (string= (aref state 7) '[X])
			(if (string= (aref state 11) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 7) '[X])
		(if (string= (aref state 11) '[X])
			(if (string= (aref state 15) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 0) '[X])
		(if (string= (aref state 5) '[X])
			(if (string= (aref state 10) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 5) '[X])
		(if (string= (aref state 10) '[X])
			(if (string= (aref state 15) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 3) '[X])
		(if (string= (aref state 6) '[X])
			(if (string= (aref state 9) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 6) '[X])
		(if (string= (aref state 9) '[X])
			(if (string= (aref state 12) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 1) '[X])
		(if (string= (aref state 6) '[X])
			(if (string= (aref state 11) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 4) '[X])
		(if (string= (aref state 9) '[X])
			(if (string= (aref state 14) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 2) '[X])
		(if (string= (aref state 5) '[X])
			(if (string= (aref state 8) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 7) '[X])
		(if (string= (aref state 10) '[X])
			(if (string= (aref state 13) '[X])
				(return-from TERMINAL-TEST 'X)
			)	
		)
	)
	(if (string= (aref state 0) '[O])
		(if (string= (aref state 1) '[O])
			(if (string= (aref state 2) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 1) '[O])
		(if (string= (aref state 2) '[O])
			(if (string= (aref state 3) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 4) '[O])
		(if (string= (aref state 5) '[O])
			(if (string= (aref state 6) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 5) '[O])
		(if (string= (aref state 6) '[O])
			(if (string= (aref state 7) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 8) '[O])
		(if (string= (aref state 9) '[O])
			(if (string= (aref state 10) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 9) '[O])
		(if (string= (aref state 10) '[O])
			(if (string= (aref state 11) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 12) '[O])
		(if (string= (aref state 13) '[O])
			(if (string= (aref state 14) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 13) '[O])
		(if (string= (aref state 14) '[O])
			(if (string= (aref state 15) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 0) '[O])
		(if (string= (aref state 4) '[O])
			(if (string= (aref state 8) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 4) '[O])
		(if (string= (aref state 8) '[O])
			(if (string= (aref state 12) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 1) '[O])
		(if (string= (aref state 5) '[O])
			(if (string= (aref state 9) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 5) '[O])
		(if (string= (aref state 9) '[O])
			(if (string= (aref state 13) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 2) '[O])
		(if (string= (aref state 6) '[O])
			(if (string= (aref state 10) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 6) '[O])
		(if (string= (aref state 10) '[O])
			(if (string= (aref state 14) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 3) '[O])
		(if (string= (aref state 7) '[O])
			(if (string= (aref state 11) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 7) '[O])
		(if (string= (aref state 11) '[O])
			(if (string= (aref state 15) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 0) '[O])
		(if (string= (aref state 5) '[O])
			(if (string= (aref state 10) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 5) '[O])
		(if (string= (aref state 10) '[O])
			(if (string= (aref state 15) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 3) '[O])
		(if (string= (aref state 6) '[O])
			(if (string= (aref state 9) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 6) '[O])
		(if (string= (aref state 9) '[O])
			(if (string= (aref state 12) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 1) '[O])
		(if (string= (aref state 6) '[O])
			(if (string= (aref state 11) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 4) '[O])
		(if (string= (aref state 9) '[O])
			(if (string= (aref state 14) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 2) '[O])
		(if (string= (aref state 5) '[O])
			(if (string= (aref state 8) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	(if (string= (aref state 7) '[O])
		(if (string= (aref state 10) '[O])
			(if (string= (aref state 13) '[O])
				(return-from TERMINAL-TEST 'O)
			)	
		)
	)
	
	(if
		(and
			(string/= (aref state 0) '[_])
			(string/= (aref state 1) '[_])
			(string/= (aref state 2) '[_])
			(string/= (aref state 3) '[_])
			(string/= (aref state 4) '[_])
			(string/= (aref state 5) '[_])
			(string/= (aref state 6) '[_])
			(string/= (aref state 7) '[_])
			(string/= (aref state 8) '[_])
			(string/= (aref state 9) '[_])
			(string/= (aref state 10) '[_])
			(string/= (aref state 11) '[_])
			(string/= (aref state 12) '[_])
			(string/= (aref state 13) '[_])
			(string/= (aref state 14) '[_])
			(string/= (aref state 15) '[_])
		)
		(return-from TERMINAL-TEST 'T)
	)
	'F
)

; Min-value function. Plays out player
; moves on the virtual gameboard.
; Returns the lowest-utility action that
; player can make.
(defun MIN-VALUE(state)
	(setq terminal (TERMINAL-TEST state))
	(if (or (string= terminal 'O) (string= terminal 'X) (string= terminal 'T))
		(return-from MIN-VALUE (UTILITY state))
	)
	(setq utility 10)
	(setq actions (ACTIONS state))
	(dolist (action actions)
		(setq utility (min utility (MAX-VALUE (X-RESULT state action))))
		(UNDO state action)
		(if (= utility -1)
				(return-from MIN-VALUE utility)
		)
	)
	utility
)

; Max-value function. Plays out computer
; moves on the virtual gameboard.
; Returns the highest-utility action that
; computer can make.
(defun MAX-VALUE(state)
	(setq terminal (TERMINAL-TEST state))
	(if (or (string= terminal 'O) (string= terminal 'X) (string= terminal 'T))
		(return-from MAX-VALUE (UTILITY state))
	)
	(setq utility -10)
	(setq actions (ACTIONS state))
	(dolist (action actions)
		(setq utility (max utility (MIN-VALUE (O-RESULT state action))))
		(UNDO state action)
		(if (= utility 1)
				(return-from MAX-VALUE utility)
		)
	)
	utility
)

; Returns a list of possible actions based on
; the current state of the gameboard.
(defun ACTIONS(state)
	(setq actions NIL)
	(dotimes (index 16)
		(if (string= (aref state index) '[_])
			(push index actions)
		)
	)
	actions
)

; Sets a space back to blank. This function is particularly
; useful when the computer is playing out moves on the virtual
; gameboard, and needs to traverse back up a subtree in order
; to explore other subtress.
(defun UNDO (state action)
	(setf (aref state action) '[_])
	state
)

; Transition model for player moves. If a space is blank,
; then an X can be placed on it. Returns state after move is made.
(defun X-RESULT(state action)
	(if (string= (aref state action) '[_])
		(setf (aref state action) '[X])
	)
	state
)

; Transition model for computer moves. If a space is blank,
; then an O can be placed on it. Returns state after move is made.
(defun O-RESULT(state action)
	(if (string= (aref state action) '[_])
		(setf (aref state action) '[O])
	)
	state
)

; Utility function.
;	The utility model is as follows:
;			If the terminal test results in an X-win (player win), return -1.
;			If the terminal test results in a tie, return 0.
;			If the terminal test results in an O-win (computer win), return 1.
;		  If the terminal test results in a state where there is no winner yet, and
;			there is no tie, return 0.
(defun UTILITY(state)
	(if (string= (TERMINAL-TEST state) 'X)
		(return-from UTILITY -1)
	)
	(if (string= (TERMINAL-TEST state) 'T)
		(return-from UTILITY 0)
	)
	(if (string= (TERMINAL-TEST state) 'O)
		(return-from UTILITY 1)
	)
	(if (string= (TERMINAL-TEST state) 'F)
		(return-from UTILITY 0)
	)
)

; MINIMAX-DECISION.
; A virtual gameboard is initialized outside of this function, containing
; the same state as the current real gameboard. The virtual gameboard is passed
; to this function.
; Gets all possible actions in the current state and places them in a list.
; The utility of each action is calculated after an action's subtree is explored
; for terminal states. The utility of an action is placed in an array whose indices 
; map directly to the action from the action list. Subtree traversal is effectively 
; pruned as soon as a terminal state of 1 (computer win) is found.
; If no utility values of 1 are discovered, then the computer searches for any utility
; values of 0, and so on.
; An action corresponding to the highest utility is returned.
(defun connect-3(state)
	(setq actionlist (ACTIONS state))
	(setq listlength (list-length actionlist))
	(setf utilitylist (make-array listlength))
	(dotimes (index (array-total-size utilitylist))
			(setf
				(aref utilitylist index) 
				(MIN-VALUE (O-RESULT state (nth index actionlist)))
			)
			(UNDO state (nth index actionlist))
			(if (= (aref utilitylist index) 1)
				(return-from connect-3 (nth index actionlist))
			)
	)
	(dotimes (index (list-length actionlist))
		(if (= (aref utilitylist index) 0)
			(return-from connect-3 (nth index actionlist))
		)
	)
	(dotimes (index (list-length actionlist))
		(if (= (aref utilitylist index) -1)
			(return-from connect-3 (nth index actionlist))
		)
	)
)



;=================
; Setting up game
;=================

(princ "X = Player") (terpri)
(princ "O = Computer") (terpri)
(princ "Computer moves first.") (terpri)
(setq gameboard (generate-gameboard))
(display-gameboard gameboard) (terpri)

;===========
; Game loop
;===========

(loop

	;===============
	; Computer turn
	;===============

	(terpri) (princ "O turn . . .")
	; Initialize virtual gameboard.
	(setq virtualgameboard (make-array '(16)))
	(dotimes (index 16)
		(setf (aref virtualgameboard index) (aref gameboard index))
	)
	(setq action (connect-3 virtualgameboard))
	(o-turn gameboard action)
	(display-gameboard gameboard) (terpri)
	; Terminal test after computer's move
	(if (string= (TERMINAL-TEST gameboard) 'O)
		(return (princ "O wins!"))
	)

	;=============
	; Player turn
	;=============

	(terpri) (princ "X turn: ")
	(setq userinput (read))
	(x-turn gameboard userinput)
	(display-gameboard gameboard) (terpri)
	; Terminal test after player's move
	(if (string= (TERMINAL-TEST gameboard) 'X)
		(return (princ "X wins!"))
	)

	; A maximum of 16 moves can be made in 4x4 tic-tac-toe.
	; If there is no winner on the 16th move, then the game
	; ends in a draw.
	(if (string= (TERMINAL-TEST gameboard) 'T)
		(return (princ "It's a tie!"))
	)
)