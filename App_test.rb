require "minitest/autorun"
require_relative "App.rb"
require_relative "Memory.rb"

class App_test < Minitest::Test
  
  def test_think
      state=[1, 2, 1, 0, 2, 1, 0, 0, 0]
      assert_equal(7, think(state).square)
  end
  
end