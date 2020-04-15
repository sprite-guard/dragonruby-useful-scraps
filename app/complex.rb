class Complex

  def initialize(r, i)
    @r = r
    @i = i
  end
  
  def serialize
    { r: @r, i: @i }
  end
  
  def inspect
    serialize.to_s
  end
  
  def to_s
    serialize.to_s
  end
  
  def real
    @r
  end
  
  def imaginary
    @i
  end
  
  def conjugate
    Complex.new(@r, -1 * @i)
  end
  
  def *(other)
    # (a+bi)(c+di) = (ac - bd) + (adi + bci)
    ac = @r * other.real
    bd = @i * other.imaginary
    ad = @r * other.imaginary
    bc = @i * other.real
    realpart = (ac - bd)
    ipart = (ad + bc)
    return Complex.new(realpart, ipart)
  end
  
  def +(other)
    Complex.new(@r + other.real, @i + other.imaginary)
  end
  
end