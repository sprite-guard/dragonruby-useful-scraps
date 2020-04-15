# just shows off the other scraps in motion
$gtk.reset
require 'app/circle.rb'
require 'app/bezier.rb'
require 'app/bzflower.rb'
require 'app/complex.rb'
require 'app/complexrotation.rb'

def tick args
  
  puts "tick" + args.state.tick_count.to_s

  # circle rendering demo
  circ ||= Circle.new(resolution: 6, scaling: :static, scale_rate: 3, color: [255, 255, 255])
  args.state.test_circle ||= { :x => 300, :y => 300, :r => 100 }
  args.state.bz_circle ||= { :x => 300, :y => 300, :r => 150 }
  bez ||= BezierFlower.new(args.state.test_circle, args.outputs.lines, resolution: 10, color: [255, 255, 255])
  
  args.outputs.background_color = [ 0, 20, 40 ]
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
  
  args.state.bz_circle[:x] = args.state.test_circle[:x]
  args.state.bz_circle[:y] = args.state.test_circle[:y]
  args.state.bz_circle[:r] = args.state.test_circle[:r] * 1.5

  bez.center[:x] = args.state.test_circle[:x]
  bez.center[:y] = args.state.test_circle[:y]

  debug_pts = circ.divide(args.state.test_circle)

  c = args.state.test_circle
  
  circ.scaling = :static
  circ.draw args.state.bz_circle, bez
  circ.scaling = :dynamic
  circ.draw args.state.test_circle, args.outputs.lines
  
  # complex rotations demo
  if args.state.tick_count == 0
    clock_center = args.state.test_circle
    clock_outer = {
      x: args.state.clock_center[:x] + 64,
      y: args.state.clock_center[:y] + 64
    }
    args.state.clock_center = clock_center
    args.state.clock_outer = clock_outer
    args.state.clock_rotation = ComplexRotation.heading clock_center, clock_outer
    args.state.tick_size = ComplexRotation.new((1/60) * Math::PI)

  end

  puts "point A:"
  puts args.state.test_circle
  
  args.state.clock_center[:x] = args.state.test_circle[:x]
  args.state.clock_center[:y] = args.state.test_circly[:y]
  
  puts "point B"
  puts args.state.test_circle

  
  args.state.clock_rotation = args.state.clock_rotation + args.state.tick_size
  ctr = args.state.clock_center
  pt = args.state.clock_outer
  next_point = args.state.clock_rotation.rotate_around pt, origin: ctr
  args.state.clock_outer = next_point
  
  args.outputs.solids << [ args.state.clock_center, [3,3], 255, 255, 255 ]
  
  args.outputs.lines << [ args.state.clock_center, args.state.clock_outer, 255, 255, 255 ]
end
