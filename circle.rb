class Circle
  attr_accessor :resolution, :scaling, :scale_rate, :color

  def initialize resolution: 8, scaling: :dynamic, scale_rate: 8, color: [0, 0, 0, 255]
    # if scaling is :dynamic, the number of points returned
    # scales with the radius of the circle, starting at the
    # base resolution and increasing by 1 every time r increases
    # by the scale_rate.
    @resolution = resolution
    @scaling = scaling
    @scale_rate = scale_rate
    
    # I realize in retrospect making this a member is kinda eh.
    # but it has an attr_accessor so just change it when you want.
    @color = color
  end

  def draw circle, renderer
    # "circle" here is the actual circle entity,
    # which is basically just a center and a radius.
    # it is emphatically NOT a circle object.
    # This circle class is just a bunch of verbs
    # that can be used on anything vaguely circle-like.

    # renderer is usually args.lines, but could be anything that:
    # - implements <<
    # - expects a pair of points + a color.
    all_points = divide circle
    all_points.each_cons(2) do |a|
      renderer << [a[0], a[1], color]
    end
    renderer << [all_points[0], all_points[-1], color]
  end

  def divide c
    # expect a hash with :x, :y, and :r, all numbers

    if scaling == :dynamic
      res = @resolution + (c[:r] / scale_rate).floor
    else
      res = @resolution
    end

    TAU = 2 * Math::PI
    angle = TAU / res

    points = []

    res.times do |n|
      x_offset = c[:r] * Math.sin(n * angle)
      y_offset = c[:r] * Math.cos(n * angle)
      x = c[:x] + x_offset
      y = c[:y] + y_offset
      points << [x,y]
    end
    return points
  end

end

