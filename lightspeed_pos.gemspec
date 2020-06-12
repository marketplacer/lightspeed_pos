# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lightspeed/version'

Gem::Specification.new do |spec|
  spec.name          = "lightspeed_pos"
  spec.version       = Lightspeed::VERSION
  spec.authors       = ["Ryan Bigg"]
  spec.email         = ["git@ryanbigg.com"]

  spec.summary       = "A gem for interacting with Lightspeed's Point of Sale system"
  spec.description   = "A gem for interacting with Lightspeed's Point of Sale system"
  spec.homepage      = "https://github.com/radar/lightspeed_pos"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = "MIT"

  spec.add_dependency "activesupport"
  spec.add_dependency "yajl-ruby"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "pry"
end
