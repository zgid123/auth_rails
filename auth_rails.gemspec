# frozen_string_literal: true

require_relative 'lib/auth_rails/version'

Gem::Specification.new do |spec|
  spec.name = 'auth_rails'
  spec.version = AuthRails::VERSION
  spec.authors = ['Alpha']
  spec.email = ['alphanolucifer@gmail.com']

  spec.summary = 'Simple authentication for Rails'
  spec.description = 'Simple authentication for Rails'
  spec.homepage = 'https://github.com/zgid123/auth_rails'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(
          *%w[
            bin/
            test/
            spec/
            features/
            .git
            .circleci
            appveyor
            Gemfile
            .rubocop.yml
            .vscode/settings.json
            LICENSE.txt
            lefthook.yml
          ]
        )
    end
  end

  spec.require_paths = ['lib']

  spec.add_dependency 'jwt'
end
