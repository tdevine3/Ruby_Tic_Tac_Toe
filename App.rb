def think(state)
  memory=Memory.new
  

  
end

def turn(state)
  
  if state.count(1) > state.count(2) 
    return 2
  else
    return 1
  end
 
end
