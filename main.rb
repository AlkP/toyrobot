require "./include/message.rb"
require "./include/robot.rb"

class Main
    
  @@cardinal_direction = { 'NORTH': 1, 'EAST': 2, 'SOUTH': 3, 'WEST': 4 }
  
  def initial
    @robot = nil
  end

  def run
    available_commands
    loop do
      commamd, option = feedback
      
      case commamd
      when 'PLACE'
        add_new_robot(option)
      when 'MOVE'
        send_option('move_robot')
      when 'LEFT'
        send_option('rotate_left_robot')
      when 'RIGHT'
        send_option('rotate_right_robot')
      when 'REPORT'
        report_about_current_position
      when 'DESTROY'
        destroy_robot
      when 'Q'
        quit
      else
        wrong_command
      end
    end
  end

  private
  
  def send_option(command)
    unless check_robot_status
      puts Message.robot(:null)
    else
      send command
    end
  end
  
  def available_commands
    system 'clear'
    puts Message.available
  end
  
  def add_new_robot(option)
    x, y, f = option.split(',').map{|p| p.strip }
    @robot = Robot.new(x, y, f) if check_cardinal_direction(f)
    available_commands
  end
  
  def move_robot
    x_new = @robot.x
    y_new = @robot.y
    case @robot.f
    when 'NORTH'
      x_new += 1
    when 'EAST'
      x_new += 1
    when 'SOUTH'
      y_new -= 1
    when 'WEST'
      x_new -= 1
    end
    if check_out_of_range(x_new, y_new)
      @robot.x, @robot.y = x_new, y_new
    end
  end
  
  def rotate_left_robot
    direction = @@cardinal_direction[@robot.f.to_sym] - 1
    if direction == 0
      @robot.f = 'WEST' 
    else
      @@cardinal_direction.each_key do |key|
        @robot.f = key.to_s if @@cardinal_direction[key] == direction
      end
    end
  end
  
  def rotate_right_robot
    direction = @@cardinal_direction[@robot.f.to_sym] + 1
    if direction == 5
      @robot.f = 'NORTH' 
    else
      @@cardinal_direction.each_key do |key|
        @robot.f = key.to_s if @@cardinal_direction[key] == direction
      end
    end
  end
  
  def report_about_current_position
    puts Message.robot(:current_position)
                .gsub('Xos', @robot.x.to_s)
                .gsub('Yos', @robot.y.to_s)
                .gsub('Fos', @robot.f)
  end
  
  def destroy_robot
    @robot = nil
    puts Message.robot(:destroyed)
  end
  
  def wrong_command
    puts Message.wrong_command
  end
  
  def feedback
    print Message.system(:get_command)
    val = gets.chomp.to_s.strip.upcase
    val = /(^[A-Z]*)(.*$)/.match(val)
    command = val[1].strip
    option  = val[2].strip
    return command, option
  end
  
  def quit
    exit
  end
  
  private
  
  def check_robot_status
    return (@robot.nil? || !@robot.valid?) ? false : true
  end
  
  def check_cardinal_direction(direction)
    return ['NORTH', 'SOUTH', 'EAST', 'WEST'].include?(direction)
  end
  
  def check_out_of_range(x,y)
    return false if x < 0 || x > 4
    return false if y < 0 || y > 4
    return true
  end
  
end

main = Main.new
main.run