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
  
  def assert_required_keys(*required_keys)
    required_keys.flatten!
    required_keys.each do |k|
      raise(ArgumentError, "Key #{k} is required") unless has_key?(k)
    end
    self
  end
end