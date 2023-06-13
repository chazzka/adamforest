# frozen_string_literal: true

require_relative "lib/ml_forest/version"

Gem::Specification.new do |spec|
  spec.name = "ml_forest"
  spec.version = MlForest::VERSION
  spec.authors = ["Adam Ulrich", "Jan Krňávek"]
  spec.email = ["a_ulrich@utb.cz", "krnavek@utb.cz"]

  spec.summary = "Random Forest algorithm."
  spec.description = "Ruby implementation of the Random Forest algorithm, it allows to use services such as ml_forest/isolation."
  spec.homepage = "https://github.com/chazzka/ml_forest"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
