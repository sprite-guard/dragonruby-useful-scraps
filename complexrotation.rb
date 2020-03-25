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

end
