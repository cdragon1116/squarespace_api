Gem::Specification.new do |spec|
  spec.name        = "squarespace_api"
  spec.version     = "1.0.1"
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

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", '~> 0.13.1'
  spec.add_development_dependency "webmock", '~> 3.14'
  spec.add_development_dependency 'rake', '~> 11.2'

  spec.add_dependency "faraday", '~> 1.7'
  spec.add_dependency "faraday_middleware", '~> 1.1'
  spec.add_dependency "json", '~> 2.5'
end
