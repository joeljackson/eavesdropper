Gem::Specification.new do |s|
  s.name        = 'eavesdropper'
  s.version     = '0.0.0'
  s.date        = '2014-11-26'
  s.summary     = "Easy logging"
  s.description = "Log the things you need with completely seperate logging concerns"
  s.authors     = ["Joel Jackson"]
  s.email       = 'jackson.joel@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.homepage    =
    'https://github.com/joeljackson/eavesdropper'
  s.license       = 'MIT'

  s.add_development_dependency 'rspec'
end
