# -*- encoding: utf-8 -*-
require_relative 'lib/tic_tac_toe/version'
Gem::Specification.new do |gem|
  gem.authors       = ["James Hwang"]
  gem.email         = ["91juhwang@gmail.com"]
  gem.summary       = " "

  gem.files         = Dir['lib/**/*.rb']
  gem.executables   = ["tic_tac_toe"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tic_tac_toe_james_hwang"
  gem.require_paths = ["lib"]
  gem.version       = TicTacToe::Version::VERSION

  gem.add_dependency 'rspec'
end