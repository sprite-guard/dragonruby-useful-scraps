class Circle
  attr_accessor :resolution, :scaling, :scale_rate, :color

  def initialize resolution: 8, scaling: :dynamic, scale_rate: 8, color: [100, 100, 100, 255]
    @resolution = resolution
    @scaling = scaling
    @scale_rate = scale_rate
    @color = color
  end

  def draw circle, renderer
    all_points = divide circle
    all_points.each_cons(2) do |a|
      renderer << [a[0], a[1], color]
    end
    renderer << [all_points[0], all_points[-1], color]
  end

  def divide c
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

