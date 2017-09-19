require "minitest/autorun"
require_relative "App.rb"
require_relative "Memory.rb"

class App_test < Minitest::Test
  
  def test_think
      state = [1, 2, 1, 0, 2, 1, 0, 0, 0]
      assert_equal(7, think(state).square)
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
    memories=[Memory.new(1,2), Memory.new(-1,1)]
    assert_equal(Memory.new(-1,1), choose_memory(memories, 2))
    a1sert_equal(Memory.new(1,2), choose_memory(memories, 1))
  end
  
  def test_get_score
    state1 = [1, 2, 1, 0, 2, 1, 0, 2, 0] # O wins
    state2 = [1, 2, 1, 2, 1, 1, 2, 1, 2] # tie
    state3 = [1, 1, 1, 2, 1, 2, 2, 2, 1] # X wins and full board
    assert_equal(-4, get_score(state1))    
    assert_equal(0, get_score(state2))    
    assert_equal(1, get_score(state3))    
  end
  
end