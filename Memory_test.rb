require "minitest/autorun"
require_relative "Memory.rb"

class Memory_test < Minitest::Test
  
  def test_memory
    memory = Memory.new(1,0) #Input: Move Score , Board Square
    assert_equal(1, memory.score)
    assert_equal(0, memory.square)
  end
  
end