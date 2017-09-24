require 'sinatra'
require_relative 'Memory.rb'
$marks = Array.new(9,"blank_mark")
$state = Array.new(9,0)


def think(state)
  memories = []
  if state.count(0) == 0 then return Memory.new(get_score(state), nil); end
  state.each_with_index do |square, index|
    if square != 0
      next
    end
    thinking_state = state.clone
    thinking_state[index] = turn(state)
    new_memory = think(thinking_state)
    new_memory.square = index
    memories.push(new_memory)
  end
  return choose_memory(memories, turn(state))
end

def turn(state)
  if state.count(1) > state.count(2) 
    return 2
  else
    return 1
  end
end

def choose_memory(memories, player)
    if player == 1
      return memories.max_by {|memory| memory.score}
    else
      return memories.min_by {|memory| memory.score}
    end
end

def get_score(state)
  (get_winner(state)*(-2)+3)*(1+state.count(0))  
end

def get_winner(state)
  [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]].each do |winning_combination|
    if state[winning_combination[0]] == state[winning_combination[1]] && state[winning_combination[0]] == state[winning_combination[2]]
      return state[winning_combination[0]]
    end
  end
  return 1.5
end

get '/' do
  erb :webpage
end

def get_mark(square)
  if square == 1
    return "x_mark"
  else
    if square == 2
      return "o_mark"
    else
      return "blank_mark"
    end
  end
end

def opponent_move
  thought = think($state)
  square = thought.square
  $state[square] = turn($state)
  $marks[square] = get_mark($state[square])
end

def player_move(square)
  if $state[square] == 0
    $state[square] = turn($state)
    $marks[square] = get_mark($state[square])
    return true
  end
  return false
end

def turn_wrapper(square)

end

(0...9).each {|square|
  get '/click' + square.to_s do
    player_move(square)
    #turn_wrapper(square)
    redirect '/'
  end
}
