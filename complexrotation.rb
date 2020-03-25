class ComplexRotation

  attr_accessor :z

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
