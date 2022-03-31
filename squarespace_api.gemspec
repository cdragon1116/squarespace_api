Gem::Specification.new do |spec|
  spec.name        = "squarespace_api"
  spec.version     = "1.0.0"
  spec.summary     = "Ruby gem interacting with the Squarespace API."
  spec.description = "Ruby gem interacting with the Squarespace API."
  spec.authors     = ["cdragon"]
  spec.email       = "cdragon1116@gmail.com"
  spec.homepage    = "https://github.com/cdragon1116/squarespace_api"
  spec.license     = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.required_ruby_version = '>= 1.8.6'

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency 'rake', '>= 11.2.2'

  spec.add_dependency "faraday", '>= 1.7.0'
  spec.add_dependency "faraday_middleware", '>= 1.1.0'
  spec.add_dependency "json", '>= 2.5.1'
end
