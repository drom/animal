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
		YesTarget: Target{Type: "a", Index: 0},
		NoTarget:  Target{Type: "a", Index: 1},
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
			askQuestion(0)
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
	fmt.Println("Animals I already know are:")
	for _, v := range animals {
		fmt.Println(v)
	}
}

func askQuestion(i int) {
	var t *Target

	q := questions[i]

	for t == nil {
		fmt.Println(q.Question + "?")

		switch strings.ToLower(getInput())[:1] {
		case "n": //No
			t = &q.NoTarget
		case "y": //Yes
			t = &q.YesTarget
		default:
			fmt.Println("Please answer yes or no.")
		}
	}

	//ask a question or guess an animal
	if t.Type == "a" {
		guessAnimal(t.Index)
	} else {
		askQuestion(t.Index)
	}
}

func guessAnimal(i int) bool {
	for true {
		fmt.Println("Is " + animals[i] + " your animal?")

		switch strings.ToLower(getInput())[:1] {
		case "n": //No
			return false
		case "y": //Yes
			return true
		default:
			fmt.Println("Please answer yes or no.")
		}
	}

	//this is impossible to reach, as the loop is infinite unless return is triggered by a case
	//but golint wants a return statement
	return false
}

func getInput() (input string) {
	input, _ = reader.ReadString('\n')
	return
}
