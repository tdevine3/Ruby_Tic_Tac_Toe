require "minitest/autorun"
require_relative "App.rb"
require_relative "Memory.rb"

class App_test < Minitest::Test
  
  def test_think
      state1 = [1, 1, 0, 2, 2, 1, 1, 2, 2]
      state2 = [1, 2, 1, 0, 2, 1, 0, 0, 0]
      state3 = [1, 2, 0, 0, 1, 0, 0, 0, 2]
      assert_equal(2, think(state1).square)
      assert_equal(7, think(state2).square)
      assert_equal(3, think(state3).square)
  end
  
  def test_turn
    state1 = [1, 2, 1, 0, 2, 1, 0, 0, 0]
    state2 = [1, 2, 1, 0, 2, 0, 0, 0, 0]
    state3 = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert_equal(2, turn(state1))
    assert_equal(1, turn(state2))
    assert_equal(1, turn(state3))
  end
  
  def test_choose_memory
    memory1 = Memory.new(1,2)
    memory2 = Memory.new(-1,1)
    memories = [memory1, memory2]
    assert_equal(memory1, choose_memory(memories, 1))
    assert_equal(memory2, choose_memory(memories, 2))
  end
  
  def test_get_score
    state1 = [1, 2, 1, 0, 2, 1, 0, 2, 0] # O wins
    state2 = [1, 2, 1, 2, 1, 1, 2, 1, 2] # tie
    state3 = [1, 1, 1, 2, 1, 2, 2, 2, 1] # X wins and full board
    assert_equal(-4, get_score(state1))    
    assert_equal(0, get_score(state2))    
    assert_equal(1, get_score(state3))    
  end
  
  def test_get_winner
    state1 = [1, 2, 1, 0, 2, 1, 0, 2, 0] # O wins
    state2 = [1, 2, 1, 2, 1, 1, 2, 1, 2] # tie
    state3 = [1, 1, 1, 2, 1, 2, 2, 2, 1] # X wins and full board
    state4 = [2, 0, 1, 2, 1, 0, 1, 0, 0] # diagonal test
    assert_equal(2, get_winner(state1))
    assert_equal(1.5, get_winner(state2)) 
    assert_equal(1, get_winner(state3))
    assert_equal(1, get_winner(state4))
  end
  
  def test_get_mark
    assert_equal("blank_mark",get_mark(0))
    assert_equal("x_mark",get_mark(1))
    assert_equal("o_mark",get_mark(2))
  end
  
  def test_opponent_move
    $marks = []
    $state = [1, 1, 0, 2, 2, 1, 1, 2, 2]
    opponent_move
    assert_equal(1, $state[2])
    assert_equal("x_mark",$marks[2])
    
    $state = [1, 2, 1, 0, 2, 1, 0, 0, 0]
    opponent_move
    assert_equal(2, $state[7])
    assert_equal("o_mark",$marks[7])
    
    $state = [1, 2, 0, 0, 1, 0, 0, 0, 2]
    opponent_move
    assert_equal(1, $state[3])
    assert_equal("x_mark",$marks[3]) 
  end
  
  def test_player_move
    $marks = []
    $state = [1, 1, 0, 2, 2, 1, 1, 2, 2]
    player_move(2)
    assert_equal(1, $state[2])
    assert_equal("x_mark",$marks[2])
    
    $state = [1, 2, 1, 0, 2, 1, 0, 0, 0] #try to move 0 into an illegal location
    $marks[0] = "x_mark"
    player_move(0)
    assert_equal(1, $state[0])
    assert_equal("x_mark",$marks[0])
  end
  
  def test_turn_wrapper
    $marks = []
    $state = [1, 1, 2, 0, 1, 0, 0, 2, 2]
    turn_wrapper(5)
    assert_equal(1,$state[5])
    assert_equal(0,$state[6])
    assert_equal("x_mark", $marks[5])
    assert_equal("o_mark", $marks[6])
    
    $marks = []
    $state = [1, 1, 2, 0, 1, 0, 0, 2, 2]
    original_state = $state.dup 
    turn_wrapper(2)
    assert_equals(original_state, $state)
    assert_equals([],$marks)
  end
end