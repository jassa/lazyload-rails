require "config"

class TestGemConfig < ::Minitest::Test
  def test_single_configuration_object
    assert_equal Lazyload::Rails.configuration, Lazyload::Rails.configuration
  end

  def test_setting_new_configuration_object
    config = Lazyload::Rails::Configuration.new
    Lazyload::Rails.configuration = config
    assert_equal Lazyload::Rails.configuration, config
  end

  def test_yields_current_configuration
    Lazyload::Rails.configure do |config|
      assert_equal config, Lazyload::Rails::configuration
    end
  end
end
