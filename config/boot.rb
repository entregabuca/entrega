ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

Gem::Specification.find_by_name('bundler', '~> 2.0.1').activate

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
