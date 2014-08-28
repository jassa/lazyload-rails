require "lazyload-rails_test"

class Lazyload::Rails::TestCase < Minitest::Test

  def test_single_configuration_object
    assert_equal Lazyload::Rails.configuration,
      Lazyload::Rails.configuration
  end

  def test_set_configuration_object
    configuration = Lazyload::Rails::Configuration.new
    Lazyload::Rails.configuration = configuration
    assert_equal Lazyload::Rails.configuration, configuration
  end

  def test_yields_current_configuration
    Lazyload::Rails.configure do |config|
      assert_equal config, Lazyload::Rails::configuration
    end
  end

end
