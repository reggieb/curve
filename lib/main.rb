$:.unshift File.join(File.dirname(__FILE__))
require 'curve'

curve = Curve.new([0, 1], [1, 1], [2, 55], [3, 66], [4, 12], [5, 1])

puts "The area under the curve is #{curve.area_under}"

[1, 2, 3, 4].each{|p| puts "At #{p} the trend is #{curve.trend(p)}"}
