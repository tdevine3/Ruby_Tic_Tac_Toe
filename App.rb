def think(state)
  memories = []
  if state.count(0) == 0 then return Memory.new(get_score(state), nil); end
  state.each_with_index do |square, index|
    if square != 0
      next
    end
    thinking_state = state.dup
    thinking_state[index] = turn(thinking_state)
    new_memory = think(thinking_state)
    new_memory.square = square
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
  
end
