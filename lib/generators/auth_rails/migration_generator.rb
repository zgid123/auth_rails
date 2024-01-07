# frozen_string_literal: true

module AuthRails
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path('templates', __dir__)

    class_option :strategy,
                 aliases: '-strat',
                 type: :string,
                 desc: 'Strategy to use, default is AuthRails::Strategies::BaseStrategy',
                 default: 'base'

    class_option :model,
                 aliases: '-m',
                 type: :string,
                 desc: 'Model for strategy to associate with',
                 default: 'user'

    def create_migration_files
      @model = (options[:model] || 'user').underscore.to_sym

      case options[:strategy]
      when 'allowed_token'
        migration_template(
          'allowed_tokens.tt',
          'db/migrate/create_allowed_tokens.rb',
          migration_version: migration_version
        )
      end
    end

    class << self
      def next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end
    end

    private

    def versioned_migrations?
      Rails::VERSION::MAJOR >= 5
    end

    def migration_version
      return unless versioned_migrations?

      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    end
  end
end
