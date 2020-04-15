# NB has not been thoroughly tested
class ComplexRotation

  attr_accessor :z
  
  def self.heading from, to
    x_offset = to[:x] - from[:x]
    y_offset = to[:y] - from[:y]
    return ComplexRotation.new(Math.atan2(y_offset, x_offset))
  end

  def initialize theta
    @z = Complex(Math.cos(theta), Math.sin(theta))
  end

  def angle
    return @z.to_angle
  end

  def +(other)
    return ComplexRotation.new(@z * other.z)
  end

  def -(other)
    return ComplexRotation.new(@z * other.z.conjugate)
  end
  
  def is_complexrotation
    true
  end
  
  def normal
    return { x: @z.real, y: @z.imaginary }
  end
  
  def rotate_around point, origin: { x: 0, y: 0 }
    centered_point = { x: point[:x] - origin[:x], y: point[:y] - origin[:y] }
    c_as_complex = Complex.rectangular(centered_point[:x], centered_point[:y])
    new_point_centered = c_as_complex * @z
    new_point = {
      x: new_point_centered.real + origin[:x],
      y: new_point_centered.imaginary + origin[:y]
    }
    return new_point
  end
end
