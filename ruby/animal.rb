#!/usr/bin/ruby

require 'json'

class AnimalGame
  attr_accessor :msg

  def initialize
    @msg = JSON.load(File.open("../text.json", "r"))
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
