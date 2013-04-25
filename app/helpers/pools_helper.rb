module PoolsHelper

  def y_or_n(a)
    if a.nil?
      ""
    else
      a ? "yes" : "no"
    end
  end
end
