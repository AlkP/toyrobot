class Robot
  
  attr_accessor :x, :y, :f
  
  def initialize x = nil, y = nil, f = nil
    @x = x.to_i
    @y = y.to_i
    @f = f
  end
  
  def valid?
    validate!
  rescue StandardError
    false
  end
  
  protected
  
  def validate!
    raise 'Out of range' if self.x < 0 || self.x > 5
    raise 'Out of range' if self.y < 0 || self.y > 5
    raise 'Not valid' unless ['NORTH', 'SOUTH', 'EAST', 'WEST'].include?(self.f)
    true
  end
  
end