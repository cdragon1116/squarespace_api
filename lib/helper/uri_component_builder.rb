class UriComponentBuidler
  def self.construct(path, params)
    path = path.dup
    path_params = path.split('/').select { |s| s.start_with?(':') }.map { |s| s[1..-1].to_sym }

    path_params.each do |key|
      raise ArgumentError, "#{key} should be passed in params" unless params[key]
      path.sub!(":#{key}", params[key].to_s)
      params.delete(key)
    end

    path.end_with?('/') ? path[0..-2] : path
  end
end
