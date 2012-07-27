# See CurveTest for examples of usage

class Curve
  attr_reader :coordinates
  
  X_INDEX = 0
  Y_INDEX = 1
  
  # Curve.new [[x1, y1], [x2, y2] .... [xn, yn]]
  #   or
  # Curve.new [x1, y1], [x2, y2] .... [xn, yn]
  def initialize(*coordinates)
    if coordinates.length == 1
      @coordinates = coordinates.first
    else
      @coordinates = coordinates
    end
     
  end
  
  def trend(at_x)
    coordinate_before = ordered_coordinates.select{|c| c[X_INDEX] < at_x}.last
    coordinate_after = ordered_coordinates.select{|c| c[X_INDEX] > at_x}.first
    
    change_in_height = (coordinate_after[Y_INDEX] - coordinate_before[Y_INDEX]).to_f
    change_in_width = (coordinate_after[X_INDEX] - coordinate_before[X_INDEX]).to_f
    
    change_in_height / change_in_width
  end
  
  def area_under
    @area_under = 0
    
    last_id = ordered_coordinates.length - 1
    ordered_coordinates.each_index do |i|
      return @area_under if i == last_id
      @area_under += trapezoid_area_for(i)
    end

  end
  
  def ordered_coordinates
    @coordinates.sort {|c, next_c| c[X_INDEX] <=> next_c[X_INDEX] } 
  end
  
  private
  def trapezoid_area_for(coordinate_index)
    coordinate = ordered_coordinates[coordinate_index]
    next_coordinate = ordered_coordinates[coordinate_index + 1]
    
    mean_height = (coordinate[Y_INDEX] + next_coordinate[Y_INDEX]) / 2.0
    width = next_coordinate[X_INDEX] - coordinate[X_INDEX]
    
    mean_height * width
  end
end
