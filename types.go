package main

//Question ...
type Question struct {
	Question  string
	YesTarget Target
	NoTarget  Target
}

//Target ...
type Target struct {
	Type  int
	Index int
}

// Target types
const (
	ANSWER   = iota
	QUESTION = iota
)
