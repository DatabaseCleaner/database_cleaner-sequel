require_relative "./lib/database_cleaner/sequel/version"

Gem::Specification.new do |spec|
  spec.name          = "database_cleaner-sequel"
  spec.version       = DatabaseCleaner::Sequel::VERSION
  spec.authors       = ["Ernesto Tagwerker", "Micah Geisel"]
  spec.email         = ["ernesto@ombulabs.com"]

  spec.summary       = "Strategies for cleaning databases using Sequel. Can be used to ensure a clean state for testing."
  spec.description   = "Strategies for cleaning databases using Sequel. Can be used to ensure a clean state for testing."
  spec.homepage      = "https://github.com/DatabaseCleaner/database_cleaner-sequel"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "database_cleaner-core", "~>2.0.0"
  spec.add_dependency "sequel"
end
