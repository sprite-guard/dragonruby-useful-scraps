# NB has not been thoroughly tested
class ComplexRotation

  attr_accessor :z
  
  def self.heading from, to
    x_offset = (to[:x] - from[:x]).to_f
    y_offset = (to[:y] - from[:y]).to_f
    return ComplexRotation.new(Math.atan2(y_offset, x_offset))
  end
  
  def self.from_complex z
    return ComplexRotation.new(z, fromcomplex: true)
  end
  
  def serialize
    { z: @z }
  end
  
  def inspect
    serialize.to_s
  end
  
  def to_s
    serialize.to_s
  end

  def initialize theta, fromcomplex: false
    if fromcomplex
      @z = theta
    else
      @z = Complex.new(Math.cos(theta), Math.sin(theta))
    end
  end

  def angle
    return @z.to_angle
  end

  def +(other)
    return ComplexRotation.from_complex(@z * other.z)
  end

  def -(other)
    return ComplexRotation.from_complex(@z * other.z.conjugate)
  end
  
  def is_complexrotation
    true
  end
  
  def normal
    return { x: @z.real, y: @z.imaginary }
  end
  
  def rotate_around point, origin: { x: 0, y: 0 }
    centered_point = { x: point[:x] - origin[:x], y: point[:y] - origin[:y] }
    c_as_complex = Complex.new(centered_point[:x], centered_point[:y])
    new_point_centered = c_as_complex * @z
    new_point = {
      x: new_point_centered.real + origin[:x],
      y: new_point_centered.imaginary + origin[:y]
    }
    return new_point
  end
end
