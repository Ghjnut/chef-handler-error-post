# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chef_handler_error_post', __FILE__)

Gem::Specification.new do |s|
  s.name = 'chef-handler-error-post'
  s.summary = 'Chef Error HTTP Poster'
  s.description = 'Reports failed chef runs to a server'
  s.version = ChefHandlerErrorPost::VERSION
  s.authors = ['Jake Pelletier']
  s.email = ['jake.pelletier@sendgrid.com']
  s.homepage = 'https://github.com/ghjnut/chef-handler-error-post'
  s.files = %w(LICENSE README.md) + Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.add_development_dependency "chef", "~> 11"
end
