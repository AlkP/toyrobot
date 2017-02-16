require "./include/message.rb"
require "./include/robot.rb"

class Main
  
  def initial
    @robot = nil
  end

  def run
    available_commands
    loop do
      commamd, option = feedback
      
      case commamd
      when 'PLACE'
        add_robot_on_board(option)
      when 'MOVE'
        send_option('move_robot')
      when 'LEFT'
        send_option('rotate_left_robot')
      when 'RIGHT'
        send_option('rotate_right_robot')
      when 'REPORT'
        report_about_current_position
      when 'DESTROY'
        send_option('destroy_robot')
      when 'Q'
        quit
      else
        wrong_command
      end
    end
  end

  private
  
  def send_option(command)
    if robot_on_board?
      send command
    # else
    #   puts Message.robot(:null)
    end
  end
  
  def add_robot_on_board(option)
    if robot_on_board?
      puts Message.robot(:double)
    else
      x, y, f = option.split(',').map{|p| p.strip }
      @robot = Robot.new(x, y, f)
      @robot = nil unless @robot.valid?
      available_commands
    end
  end
  
  def move_robot
    @robot.move!
  end
  
  def rotate_left_robot
    @robot.left!
  end
  
  def rotate_right_robot
    @robot.right!
  end
  
  def feedback
    print Message.system(:get_command)
    val = gets.chomp.to_s.strip.upcase
    val = /(^[A-Z]*)(.*$)/.match(val)
    command = val[1].strip
    option  = val[2].strip
    return command, option
  end
  
  def robot_on_board?
    return (@robot.nil?) ? false : true
  end
  
  def report_about_current_position
    if robot_on_board?
      puts Message.robot(:current_position)
                  .gsub('Xos', @robot.x.to_s)
                  .gsub('Yos', @robot.y.to_s)
                  .gsub('Fos', @robot.f)
    else
      puts Message.robot(:null)
    end
  end
  
  def available_commands
    system 'clear'
    puts Message.available
  end
  
  def wrong_command
    puts Message.system(:wrong)
  end
  
  def destroy_robot
    @robot = nil
    puts Message.robot(:destroyed)
  end
  
  def quit
    exit
  end
  
end

main = Main.new
main.run