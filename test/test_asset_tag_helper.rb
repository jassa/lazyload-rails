require "lazyload-rails_test"

class BasicController
  attr_accessor :request

  def config
    @config ||= ActiveSupport::InheritableOptions.new(ActionController::Base.config).tap do |config|
      public_dir = File.expand_path("../fixtures/public", __FILE__)
      config.assets_dir = public_dir
      config.assets = ActiveSupport::InheritableOptions.new({ :prefix => "assets" })
      config
    end
  end
end

class AssetTagHelperTest < ActionView::TestCase
  tests ActionView::Helpers::AssetTagHelper

  attr_reader :request

  def setup
    super

    @controller = BasicController.new

    @request = Class.new do
      attr_accessor :script_name
      def protocol() 'http://' end
      def ssl?() false end
      def host_with_port() 'localhost' end
      def base_url() 'http://www.example.com' end
    end.new

    @controller.request = @request
  end

  def test_lazy_attributes
    expected = '<img alt="Foo" height="150"' +
      ' src="http://www.appelsiini.net/projects/lazyload/img/grey.gif"' +
      ' width="100" data-original="/images/foo.png">'

    assert_equal expected, image_tag("foo.png", size: "100x150")
  end

  def test_lazy_attributes_override
    expected = '<img alt="Bar" data-original="/images/bar.png" height="150"' +
      ' src="http://www.appelsiini.net/projects/lazyload/img/grey.gif" width="200">'

    actual = image_tag("bar.png", size: "200x150", data: { original: "foo" })

    assert_equal expected, actual
  end
end
