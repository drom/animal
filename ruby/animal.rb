#!/usr/bin/ruby

require 'json'

class AnimalGame
  attr_accessor :msg

  def initialize
    @msg = {
      'start' => "PLAY 'GUESS THE ANIMAL'\nTHINK OF AN ANIMAL AND THE COMPUTER WILL TRY TO GUESS IT...",
      'mood' => 'ARE YOU THINKING OF AN ANIMAL ? ',
      'isItA' => 'IS IT A ',
      'again' => 'WHY NOT TRY ANOTHER ANIMAL',
      'known' => "ANIMALS I ALREADY KNOW ARE:\n",
      'itWas' => 'THE ANIMAL YOU WERE THINKING OF WAS A ? ',
      'differ' => 'PLEASE TYPE IN A QUESTION THAT WOULD differ A ',
      'fromA' =>  ' FROM A ',
      'exit' => 'O.K.  SEE YOU LATER.  HOPE YOU HAD FUN PLAYING!!',
      'data' => ['DOES IT SWIM', 'FISH', 'BIRD']
    }
  end

  def start
    print @msg['mood']
    answer = gets.chomp
    if answer == 'l'
      puts @msg['known'] + JSON.pretty_generate(@msg['data'])
      start
    elsif answer == 'y'
      traverse(msg, 'data')
    else
      puts @msg['exit']
    end
  end
  
  def traverse(parent, path)
    node = parent[path]
    if node.class == String
      print @msg['isItA'] + node + ' ? '
      answer = gets.chomp
      if answer == 'y'
        puts @msg['again']
        start
      else
        print @msg['itWas']
        itwas = gets.chomp
        print @msg['differ'] + itwas + @msg['fromA'] + node + ': '
        differ = gets.chomp
        parent[path] = [differ, itwas, node]
        puts @msg['again']
        start
      end
    else
      print node[0] + ' ? '
      answer = gets.chomp
      if answer == 'y'
        traverse(node, 1)
      else
        traverse(node, 2)
      end
    end
  end
end

def play
  animal_game = AnimalGame.new
  puts animal_game.msg['start']
  animal_game.start
end

play
