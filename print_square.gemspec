# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'print_square/version'

Gem::Specification.new do |gem|
  gem.name          = "print_square"
  gem.version       = PrintSquare::VERSION
  gem.authors       = ["Chris Boertien"]
  gem.email         = ["chris@aktionlab.com"]
  gem.description   = %q{A simple command that validates a square number and prints it in a design}
  gem.summary       = %q{Validates squares and prints it in a design}
  gem.homepage      = "http://aktionlab.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ["print_square"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport', '~> 3.2.9'
end
