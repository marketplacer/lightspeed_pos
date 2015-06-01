# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lightspeed/version'

Gem::Specification.new do |spec|
  spec.name          = "lightspeed-pos"
  spec.version       = Lightspeed::Pos::VERSION
  spec.authors       = ["Ryan Bigg"]
  spec.email         = ["git@ryanbigg.com"]

  spec.summary       = %q{A gem for interacting with Lightspeed's Point of Sale system}
  spec.description   = %q{A gem for interacting with Lightspeed's Point of Sale system}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "0.13.5"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "3.2.0"
  spec.add_development_dependency "webmock", "1.21.0"
  spec.add_development_dependency "vcr", "2.9.3"

  spec.add_development_dependency "pry"
end
