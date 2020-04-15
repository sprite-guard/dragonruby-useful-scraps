class Kite
  attr_accessor :ratio

  def initialize ratio: 1
    @ratio = ratio
  end
  
  def draw k, renderer
    vertical = k[:vertical]
    vr = vertical / 2
    horizontal = k[:horizontal]
    hr = horizontal / 2
    rotation = k[:rotation]
  end
end