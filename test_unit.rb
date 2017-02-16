require "./include/robot.rb"
require 'test/unit'

class MyRobotTestCase1 < Test::Unit::TestCase
  def setup
    @robot1 = Robot.new(2,2,'WEST')
    @robot2 = Robot.new(2,3,'QWE')
    @robot3 = Robot.new(5,5,'WEST')
  end

  def test1
    assert( @robot1.valid?, "Validate doesn't work" )
    assert( !@robot2.valid?, "Validate doesn't work" )
    assert( !@robot3.valid?, "Validate doesn't work" )
  end
  
  def test2
    old = @robot2.report.to_a
    @robot2.move!
    assert( old == @robot2.report.to_a, "Robot move" )
  end
  
  def test3
    old = @robot1.report.to_a
    @robot1.move!
    assert( old != @robot1.report.to_a, "Robot move" )
    old = @robot1.report.to_a
    @robot1.move!
    assert( old != @robot1.report.to_a, "Robot move" )
    old = @robot1.report.to_a
    @robot1.move!
    assert( old == @robot1.report.to_a, "Robot don't move" )
    @robot1.left!
    assert( old != @robot1.report.to_a, "Robot rotate" )
  end
end