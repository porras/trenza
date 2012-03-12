Gem::Specification.new do |s|
  s.name              = 'trenza'
  s.version           = '0.2.0'
  s.summary           = 'Adds laziness & parallelism to any Ruby object in a transparent way'
  s.author            = 'Sergio Gil'
  s.email             = 'sgilperez@gmail.com'
  s.homepage          = 'http://github.com/porras/trenza'
  
  s.files             = %w(README.md) + Dir.glob('{lib/**/*}') + Dir.glob('{examples/**/*}')
  s.require_paths     = ['lib']
end