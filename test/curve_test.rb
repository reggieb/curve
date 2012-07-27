$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'curve'

class CurveTest < Test::Unit::TestCase
  
  def test_coordinates
    coordinates = [[0, 1], [1, 1]]
    assert_equal(coordinates, Curve.new([[0, 1], [1, 1]]).coordinates, "Should be able to pass in an array of coordinates arrays")
    assert_equal(coordinates, Curve.new([0, 1], [1, 1]).coordinates, "Should be able to pass in coordinates as series of arrays")
  end
  
  def test_area_under
    @curve = Curve.new([0, 1], [1, 1])
    assert_equal(1, @curve.area_under)
    
    @curve = Curve.new([0, 2], [1, 2])
    assert_equal(2, @curve.area_under)
    
    @curve = Curve.new([0, 2], [2, 2])
    assert_equal(4, @curve.area_under)
    
    @curve = Curve.new([0, 0], [1, 1])
    assert_equal(0.5, @curve.area_under)
    
    @curve = Curve.new([0, 0], [1, 1], [2, 1])
    assert_equal(1.5, @curve.area_under)
  end
  
  def test_trend
    @curve = Curve.new([0, 1], [1, 1])
    assert_equal(0, @curve.trend(0.5))
    
    @curve = Curve.new([0, 0], [1, 1])
    assert_equal(1, @curve.trend(0.5))
    
    
    @curve = Curve.new([0, 0], [2, 1])
    assert_equal(0.5, @curve.trend(0.5))
    
    @curve = Curve.new([0, 1], [2, 0])
    assert_equal(-0.5, @curve.trend(0.5))
  end
  
  def test_trend_at_point
    point_1 = [0, 0]
    point_2 = [1, 1]
    point_3 = [2, 4]
    @curve = Curve.new(point_1, point_2, point_3)
    assert_equal(1, @curve.trend(0.5), "before point 2 trend should be slope between points 1 and 2")
    assert_equal(3, @curve.trend(1.5), "after point 2 trend should be slope between points 2 and 3")
    assert_equal(2, @curve.trend(1), "at point 2 trend should be slope between points 1 and 3")
  end
  
  def test_ordered_coordinates
    coordinates = [[0, 1], [1, 1]]
    @curve = Curve.new(coordinates)
    assert_equal(coordinates, @curve.ordered_coordinates)
    
    @curve = Curve.new(coordinates.reverse)
    assert_equal(coordinates, @curve.ordered_coordinates)
  end
end
