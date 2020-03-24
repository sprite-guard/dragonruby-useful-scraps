require 'app/bezier.rb'

class BezierFlower
  attr_accessor :center, :color, :renderer, :resolution, :bezier

  def initialize center, renderer, resolution: 20
    @resolution = resolution
    @center = center
    @renderer = renderer
    @bezier = Bezier.new
  end

  def << line
    # line is [ x1, y1, x2, y2, color ]
    color = line[4]
    c = [ center[:x], center[:y] ]
    renderer << @bezier.lines(c[0],c[1], *line[0], *line[1], c[0], c[1], resolution)
  end
end
