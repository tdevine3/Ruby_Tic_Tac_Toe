def think(state)
  memories = []
  state.each_with_index do |square, index|
    if square != 0
      next
    end
    thinking_state = state.dup
    thinking_state[index] = turn(thinking_state)
    memories.push(think(thinking_state))
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
    memory = Memory.new
end
