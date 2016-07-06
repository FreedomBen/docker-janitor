# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docker_janitor/version'

Gem::Specification.new do |s|
  s.name        = 'docker_janitor'
  s.version     = DockerJanitor::VERSION
  s.date        = '2016-07-06'
  s.summary     = 'docker janitor helps you clean up after the' \
    ' sometimes messy house guest known as docker'
  s.description = 'The slack web api is good, but very raw.  '
  s.authors     = ['Ben Porter']
  s.email       = 'BenjaminPorter86@gmail.com'
  s.files       = ['lib/docker_janitor.rb'] + Dir['lib/docker_janitor/**/*']
  s.homepage    = 'https://github.com/FreedomBen/docker-janitor'
  s.license     = 'MIT'

  s.executables << 'docker-janitor'

  s.add_runtime_dependency 'colorize', '~> 0.7'
  s.add_runtime_dependency 'thor', '~> 0.19'
  s.add_runtime_dependency 'sys-filesystem', '~> 1.1'

  s.add_development_dependency 'byebug', '~> 4.0'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'rake', '~> 10.5'
end
