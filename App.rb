require 'sinatra'
require_relative 'Memory.rb'

$marks = Array.new(9,"blank_mark") #initialize
$state = Array.new(9,0)
$message = ''

def think(state)
  memories = []
  winner = get_winner(state)
  if winner != 0
    return Memory.new(get_score(state), nil)
  end
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

def turn(state) #change turns
  if state.count(1) > state.count(2) 
    return 2
  else
    return 1
  end
end

def choose_memory(memories, player) #return minimum score for O, max for X
  if player == 1
    return memories.max_by {|memory| memory.score}
  else
    return memories.min_by {|memory| memory.score}
  end
end

def get_score(state) #negative scores for O, positive for X, favors short solutions
  (get_winner(state)*(-2)+3)*(1+state.count(0))  
end

def get_winner(state) #check the state of the board against the winning combinations
  [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]].each do |winning_combination|
    if state[winning_combination[0]] == state[winning_combination[1]] && state[winning_combination[0]] == state[winning_combination[2]] && state[winning_combination[0]] != 0
      return state[winning_combination[0]]
    end
  end
  if state.count(0) != 0 #no winners found
    return 0
  end
  return 1.5 #tie game
end

def get_mark(square) #mark the square
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

def turn_wrapper(square) #if the player moves successfully the opponent moves
  valid_move = player_move(square)
  if valid_move && get_winner($state) == 0
    opponent_move
  end
end

def reset #clear the board
  $marks = Array.new(9,"blank_mark")
  $state = Array.new(9,0)
end

(0...9).each {|square|
  get '/click' + square.to_s do
    turn_wrapper(square)
    if get_winner($state) != 0
      redirect '/end'
    end
    redirect '/'
  end
}

get '/' do
  erb :webpage
end

get '/end' do
  $message = ''
  winner = get_winner($state)
  $message = 'X Wins' if winner == 1
  $message = 'O Wins' if winner == 2
  $message = 'Tie Game' if winner == 1.5
  reset
  erb :end
end

get '/switch_player' do
  if get_winner($state) == 0
    if $state.count(0) == 9
      player_move(4)
    else
      opponent_move
    end
    if get_winner($state) != 0
      redirect '/end'
    else
      redirect '/'
    end  
  else
    redirect '/end'
  end
end




