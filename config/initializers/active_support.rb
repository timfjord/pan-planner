class Hash
  def transform_values!
    keys.each do |key|
      self[key] = yield(delete(key))
    end
    self
  end
  
  def transform_values
    result = {}
    each_key do |key|
      result[key] = yield(self[key])
    end
    result
  end
end