class Robot
  
  attr_accessor :x, :y, :f
  
  CARDINAL_DIRECTION = { NORTH: 1, EAST: 2, SOUTH: 3, WEST: 4 }
  Xmin = 0
  Xmax = 4
  Ymin = 0
  Ymax = 4
  
  def initialize( x = nil, y = nil, f = nil )
    @x = x.to_i
    @y = y.to_i
    @f = f
  end
  
  def move!
    new = Robot.new(self.x, self.y, self.f)
    case new.f
    when 'NORTH'
      new.y += 1
    when 'EAST'
      new.x += 1
    when 'SOUTH'
      new.y -= 1
    when 'WEST'
      new.x -= 1
    end
    accept_new_values(new) if new.valid?
  end
  
  def left!
    direction = CARDINAL_DIRECTION[self.f.to_sym] - 1
    if direction == 0
      self.f = 'WEST' 
    else
      CARDINAL_DIRECTION.each_key do |key|
        self.f = key.to_s if CARDINAL_DIRECTION[key] == direction
      end
    end
  end
  
  def right!
    direction = CARDINAL_DIRECTION[self.f.to_sym] + 1
    if direction == 5
      self.f = 'NORTH' 
    else
      CARDINAL_DIRECTION.each_key do |key|
        self.f = key.to_s if CARDINAL_DIRECTION[key] == direction
      end
    end
  end
  
  def valid?
    return validate!
  rescue StandardError
    return false
  end
  
  protected
  
  def accept_new_values(new)
    self.x, self.y, self.f = new.x, new.y, new.f
  end
  
  def validate!
    raise 'Out of range' if ((self.x < Xmin) || (self.x > Xmax))
    raise 'Out of range' if ((self.y < Ymin) || (self.y > Ymax))
    raise 'Not valid' unless CARDINAL_DIRECTION.map{|key, value| key.to_s }
                                               .to_a.include?(self.f)
    true
  end
  
end