Gem::Specification.new do |spec|
  spec.name        = "squarespace_api"
  spec.version     = "0.0.1"
  spec.summary     = "Ruby gem interacting with the Squarespace API."
  spec.description = "Ruby gem interacting with the Squarespace API."
  spec.authors     = ["cdragon"]
  spec.email       = "cdragon1116@gmail.com"
  spec.homepage    = "https://github.com/cdragon1116/squarespace"
  spec.license     = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "json"
  spec.add_dependency "yaml"
end
