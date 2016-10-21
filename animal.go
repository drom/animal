package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

//types

//Question ...
type Question struct {
	Question  string
	YesTarget Target
	NoTarget  Target
}

//Target ...
type Target struct {
	Type  string
	Index int
}

//Data
var animals = []string{"Fish", "Bird"}

var questions = []Question{
	Question{
		Question:  "Does it swim",
		YesTarget: Target{Type: "", Index: 0},
		NoTarget:  Target{Type: "", Index: 1},
	},
}

var reader = bufio.NewReader(os.Stdin) //we'll be needing this

//funcs
func main() {

	playIntroMessage()

	run := true
	for run {

		//let's begin
		fmt.Println("Are you thinking of an animal?")

		switch strings.ToLower(getInput())[:1] {
		case "n": //No
			//Quit the game
			run = false
		case "l": //List
			//output the animal list and then ask again
			listKnownAnimals()
		case "y": //Yes
		default:
			fmt.Println("I don't recognise that command")
		}
	}
}

func playIntroMessage() {
	fmt.Println("Play 'Guess the Animal'")
	fmt.Println("Think of an animal and the computer will try to guess it...")
}

func listKnownAnimals() {
	fmt.Println("I know the following animals")
	for _, v := range animals {
		fmt.Println(v)
	}
}

func getInput() (input string) {
	input, _ = reader.ReadString('\n')
	return
}
