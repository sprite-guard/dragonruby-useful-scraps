class Bezier

  # Based on the "cubic bezier" sample app.
  # this was all created by Amir Rajan
  # I just wrapped it in a class.

  def lines x1, y1, x2, y2, x3, y3, x4, y4, step
    step ||= 0
    color = [0, 0, 0]
    points = point_list [x1, y1], [x2, y2], [x3, y3], [x4, y4], step

    points.each_cons(2).map do |p1, p2|
      [*p1, *p2, color]
    end
  end

  def point_list p1, p2, p3, p4, step
    if step == 0
      [p1, p2, p3, p4]
    else

      t_step = 1.fdiv(step + 1)
      t = 0
      t += t_step
      points = []
      while t < 1
        points << [
          b_for_t(p1.x, p2.x, p3.x, p4.x, t),
          b_for_t(p1.y, p2.y, p3.y, p4.y, t),
        ]
        t += t_step
      end

      [
        p1,
        *points,
        p4
      ]
    end
  end

  def b_for_t v0, v1, v2, v3, t
    pow(1 - t, 3) * v0 +
    3 * pow(1 - t, 2) * t * v1 +
    3 * (1 - t) * pow(t, 2) * v2 +
    pow(t, 3) * v3
  end

  def pow n, to
    n ** to
  end
end