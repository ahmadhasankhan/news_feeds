module NewsfeedsHelper
  def covert_to_past_tens(str)
    str.sub(/e?$/, 'ed')
  end
end
