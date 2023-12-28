require 'ruby2d'

set width: 800, height: 600

Line.new(x1: 0, y1: 300, x2: 800, y2: 300, width: 1, color: 'lime', z: 20)
Line.new(x1: 400, y1: 0, x2: 400, y2: 600, width: 1, color: 'lime', z: 20)

80.times do |n|
  Line.new(x1: n * 10, y1: 295, x2: n * 10, y2: 305, width: 1, color: 'lime', z: 20)
end

60.times do |n|
  Line.new(x1: 395, y1: n * 10, x2: 405, y2: n * 10, width: 1, color: 'lime', z: 20)
end


update do |n|

end

show
