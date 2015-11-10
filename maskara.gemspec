# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maskara/version'

Gem::Specification.new do |spec|
  spec.name          = "maskara"
  spec.version       = Maskara::VERSION
  spec.authors       = ["Simon Hildebrandt"]
  spec.email         = ["simon.hildebrandt@fairfaxmedia.com.au"]

  spec.summary       = %q{Mask out your controller logic with mock data to make building views easier.}
  spec.description   = %q{Mask out your controller logic with mock data to make building views easier.}
  spec.homepage      = "https://bitbucket.org/fairfax/maskara"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'recursive-open-struct'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rails-dummy"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rails", "> 3"

end
