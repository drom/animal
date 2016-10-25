package main

var animals = []string{"Fish", "Bird"}

var questions = []Question{
	Question{
		Question:  "Does it swim",
		YesTarget: Target{Type: ANSWER, Index: 0},
		NoTarget:  Target{Type: ANSWER, Index: 1},
	},
}
