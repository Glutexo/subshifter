Gem::Specification.new do |spec|
  spec.name = 'subshifter'
  spec.version = '0.0.4'
  spec.date = '2019-04-13'
  spec.summary = 'Subtitle shifter'
  spec.description = 'A simple application to shift time in SRT subtitle files'
  spec.authors = ['Glutexo']
  spec.email = 'glutexo@icloud.com'
  spec.homepage = 'https://github.com/Glutexo/subshifter'
  spec.license = 'MIT'
  
  lib_path = File.join('lib', '**', '*')
  spec.files = Dir[lib_path].reject do |item| File.directory? item end
  spec.executables = ['subshifter']
end