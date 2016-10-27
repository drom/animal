package main

//Question ...
type Question struct {
	Question            string
	YesTarget, NoTarget Target
}

//Target ...
type Target struct {
	Type, Index int
}

// Target types
const (
	ANSWER   = iota
	QUESTION = iota
)
