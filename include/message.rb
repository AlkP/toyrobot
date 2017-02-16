module Message
  
  @message = {
    available: '
      PLACE X,Y,F will put the toy robot on the table in position X,Y and facing
           NORTH, SOUTH, EAST or WEST
      MOVE will move the toy robot one unit forward in the direction it is 
           currently facing.
      LEFT and RIGHT will rotate the robot 90 degrees in the specified direction
           without changing the position of the robot.
      REPORT will announce the X,Y and F of the robot. This can be in any form,
           but standard output is sufficient.
      DESTROY remove the robot from the board
      ----------------------------
      Q - Exit
      ',
    system: {
      wrong: 'Wrong command!' ,
      get_command: 'Get command: '
    },
    robot: {
      wrong: 'Error create',
      null: 'Robot not on board',
      new: 'Robot was created',
      destroyed: 'Robot destroyed',
      double: 'Destroy old before create new',
      current_position: "Current position X: Xos; Y: Yos; F: Fos "
    }
  }
  
  def self.available
    @message[:available]
  end
  
  def self.robot(command)
    @message[:robot][command]
  end
  
  def self.system(command)
    @message[:system][command]
  end
  
end