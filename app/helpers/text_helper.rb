module TextHelper
  def booleanize(exp)
    (exp.to_s =~ /^(yes|true|1)$/i) ? true : false
  end
end