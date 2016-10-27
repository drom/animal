package main

var answers = []string{"Fish", "Bird"}

var questions = []Question{
	Question{
		Question:  "Does it swim",
		YesTarget: Target{Type: ANSWER, Index: 0},
		NoTarget:  Target{Type: ANSWER, Index: 1},
	},
}

var text = struct {
	start, mood, isIt, again,
	known, itWas, differ, from,
	answerIs, exit string
}{
	start:    "Play 'Guess the Animal'\nThink of an animal and the computer will try to guess it...",
	mood:     "Are you thinking of an animal?",
	isIt:     "Is it ",
	again:    "Why not try another animal?",
	known:    "Animals I already know are:",
	itWas:    "What was the animal you were thinking of?",
	differ:   "Please type in a Yes/No question that would distinguish ",
	from:     " from ",
	answerIs: "What is the answer to your question for ",
	exit:     "O.K. See you later. Hope you had fun playing!",
}
