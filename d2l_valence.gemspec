# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'd2l_valence/version'

Gem::Specification.new do |spec|
  spec.name          = "d2l_valence"
  spec.version       = "0.0.1"#D2lValence::Version
  spec.authors       = ["Dave McPherson"]
  spec.email         = ["davemcp@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "faraday", [">= 0.8", "< 0.10"]
  spec.add_dependency "json", "~> 1.8"
end
