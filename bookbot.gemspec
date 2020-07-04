
require_relative "lib/bookbot/version"

Gem::Specification.new do |spec|
  spec.name          = "bookbot".freeze
  spec.version       = BookBot::VERSION
  spec.authors       = ["Leam Hall"]
  spec.email         = "freetradeleague@gmail.com"
  spec.homepage      = "https://github.com/makhidkarun/bookbot"
  Dir.glob("bin/*").each {|file|
    spec.executables   << File.basename(file)
  }
  spec.licenses      = ["OWL"]
  spec.platform      = Gem::Platform::RUBY
  spec.summary       = "CLI tools for role-playing games."
  spec.description   = <<~DESC
    CLI tools for role-playing games. Generate characters,
    dice rolls, planets, etc.
  DESC
  spec.files         = Dir.glob("{bin,data,docs,lib}/**/*")
  spec.require_paths = ["lib"]
  spec.datadir       << "data"
  spec.metadata      = {
    "homepage_uri"  => spec.homepage,
  }
  spec.add_development_dependency  'rspec', '~> 3'
  spec.add_development_dependency  'rspec-mocks', '~> 3'
  spec.add_development_dependency  'rspec-expectations', '~> 3'
end
