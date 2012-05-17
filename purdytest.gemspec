# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'purdytest/version'

Gem::Specification.new do |s|
  s.name = "purdytest"
  s.version = Purdytest::VERSION

  s.authors = ["Aaron Patterson"]
  s.email = ["aaron.patterson@gmail.com"]
  s.description = "Purdytest extends minitest with pretty colors"

  s.files = Dir.glob("{lib,test}/**/*") + %w(README.rdoc CHANGELOG.rdoc)
  s.extra_rdoc_files = ["README.rdoc"]

  s.homepage = "https://github.com/tenderlove/purdytest"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.7"
  s.summary = s.description

  s.add_runtime_dependency("minitest", [">= 2.2.2"])

  s.add_development_dependency("rake", ["~> 0.9.2.2"])
  s.add_development_dependency("hoe", ["~> 2.12.5"])
end
