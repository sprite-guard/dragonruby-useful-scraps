# just shows off the other scraps in motion

require 'app/circle.rb'
require 'app/bzflower.rb'

def tick args
  circ ||= Circle.new(resolution: 6, scaling: :static, scale_rate: 3)
  args.state.test_circle ||= { :x => 300, :y => 300, :r => 100 }
  bez ||= BezierFlower.new(args.state.test_circle, args.outputs.lines, resolution: 10)
  args.state.dr ||= 1
  args.state.dx ||= 1
  args.state.dy ||= 1
  if(args.state.test_circle[:r] < 1)
    args.state.dr = 1
  elsif(args.state.test_circle[:r] > 100)
    args.state.dr = -1
  else
    args.state.dr = args.state.dr
  end
  
  r = args.state.test_circle[:r]
  x = args.state.test_circle[:x]
  y = args.state.test_circle[:y]
  
  if(x < r)
    args.state.dx = 1
  elsif(x > (1280-r))
    args.state.dx = -1
  else
    args.state.dx = args.state.dx
  end
  
  if(y < r)
    args.state.dy = 1
  elsif(y > (720 - r))
    args.state.dy = -1
  else
    args.state.dy = args.state.dy
  end
  
  args.state.test_circle[:r] += args.state.dr
  args.state.test_circle[:x] += args.state.dx
  args.state.test_circle[:y] += args.state.dy

  bez.center[:x] = args.state.test_circle[:x]
  bez.center[:y] = args.state.test_circle[:y]

  debug_pts = circ.divide(args.state.test_circle)

  c = args.state.test_circle
  
  circ.scaling = :static
  circ.draw args.state.test_circle, bez
  circ.scaling = :dynamic
  circ.draw args.state.test_circle, args.outputs.lines
end
