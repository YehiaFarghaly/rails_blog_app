require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end
