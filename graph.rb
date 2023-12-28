require 'ruby2d'

# https://www.ruby2d.com/learn/window/
set title: "Hello Triangle"

class MyTriangle < Triangle
  POINT_COORDS=%i!x1 y1 x2 y2 x3 y3!

  def self.from_points_array(points_array:,color:)
    new(**Hash[POINT_COORDS.zip(points_array.flatten)], color: color)
  end

  def center
    @xc||=3.times.inject(0) { |a,n| send("x#{n+1}") + a } / 3.0
    @yc||=3.times.inject(0) { |a,n| send("y#{n+1}") + a } / 3.0
    {x:@xc, y:@yc}
  end

  def initialize(x1:,y1:,x2:,y2:,x3:,y3:,color:)
    super
    %w(x y).each do |l|
      3.times do |n|
        instance_variable_set("@original#{l}#{n+1}", send("#{l}#{n+1}"))
      end
    end
  end

#𝑥2=cos𝛽𝑥1−sin𝛽𝑦1
#𝑦2=sin𝛽𝑥1+cos𝛽𝑦1
  def rotate_xy(x:, y:, theta:)
    {x: Math.cos(theta) * x - Math.sin(theta) * y,
     y: Math.sin(theta) * x + Math.cos(theta) * y}
  end

  def rotate_xy_about_center(x:,y:,theta:)
    xn=x-center[:x]
    yn=y-center[:y]

    rotated=rotate_xy(x: xn, y: yn, theta: theta)
    rotated[:x]=rotated[:x] + center[:x]
    rotated[:y]=rotated[:y] + center[:y]
    rotated
  end

  def rotate(degrees_from_original)
    radians=degrees_from_original/180.0*Math::PI
    3.times do |n|
      x=instance_variable_get("@originalx#{n+1}")
      y=instance_variable_get("@originaly#{n+1}")
      rotated=rotate_xy_about_center(x:x,y:y,theta:radians)
      send "x#{n+1}=", rotated[:x]
      send "y#{n+1}=", rotated[:y]
    end
#    p self
  end
end

triangle_points=[[320, 50], [540, 430], [100, 430]]

t=[]
60.times do |n|
  t[n]=MyTriangle.from_points_array(points_array: triangle_points, color: %w(red green blue))
end

@ticker = 0
@visible=true

set width: 800, height: 600
update do
  @ticker+=0.1
  60.times do |n|
    t[n].rotate(@ticker * (n+1))
  end
end

show
