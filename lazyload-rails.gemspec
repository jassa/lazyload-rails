$:.push File.expand_path("../lib", __FILE__)
require "lazyload-rails/version"

Gem::Specification.new do |gem|
  gem.author      = ["Javier Saldana"]
  gem.email       = ["javier@tractical.com"]
  gem.homepage    = "https://github.com/jassa/lazyload-rails"
  gem.name        = "lazyload-rails"
  gem.license     = "MIT"
  gem.version     = Lazyload::Rails::VERSION
  gem.summary     = "jQuery Lazy Load for Rails image_tag helpers"
  gem.description = <<-EOS
    lazyload-rails project integrates jQuery Lazy Load
    Plugin for Rails image_tag helpers
  EOS

  gem.files       = `git ls-files`.split($/)
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency "nokogiri", "~> 1.5"
  gem.add_development_dependency "actionpack", ">= 3.1"
end
