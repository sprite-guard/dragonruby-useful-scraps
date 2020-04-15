class BezierFlower
  attr_accessor :center, :color, :renderer, :resolution, :bezier, :color

  def initialize center, renderer, resolution: 20, color: [0,0,0]
    @resolution = resolution
    @center = center
    @renderer = renderer
    @bezier = Bezier.new(color: color)
    @color = color
  end

  def << line
    # line is [ x1, y1, x2, y2, color ]
    color = line[4]
    c = [ center[:x], center[:y] ]
    renderer << @bezier.lines(c[0],c[1], *line[0], *line[1], c[0], c[1], resolution)
  end
end
