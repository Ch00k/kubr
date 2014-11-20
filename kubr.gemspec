require './lib/kubr/version.rb'


Gem::Specification.new do |s|
  s.name = 'kubr'
  s.version = Kubr::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Andriy Yurchuk']
  s.email = ['ayurchuk@minuteware.net']
  s.homepage = 'https://github.com/Ch00k/kubr'
  s.summary = 'Kubernetes REST API client'
  s.description = 'Ruby wrapper over Kubernetes REST API'
  s.license = 'MIT'

  s.add_dependency 'rest-client'
  s.add_dependency 'activesupport'

  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'
end
