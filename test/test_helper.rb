ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Load fixtures from test/fixtures/*.yml
  fixtures :all

  # Devise の Integration テスト用ヘルパーを読み込む
  include Devise::Test::IntegrationHelpers
end
