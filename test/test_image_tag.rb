require "config"

class TestImageTag < ::ActionView::TestCase
  tests ActionView::Helpers::AssetTagHelper

  def setup
    backwards_compatibility_setup
    Lazyload::Rails.reset
  end

  def test_lazy_option_sets_lazy_attributes
    img = parse(image_tag("foo.png", size: "101x151", lazy: true))

    assert_match %r(^.*foo.png$), img["data-original"]
    assert_equal "151", img["height"]
    assert_equal "101", img["width"]
  end

  def test_lazy_by_default_config_sets_lazy_attributes
    Lazyload::Rails.configure do |config|
      config.lazy_by_default = true
    end

    img = parse(image_tag("foo.png", size: "101x151"))

    assert_match %r(^.*foo.png$), img["data-original"]
    assert_equal "151", img["height"]
    assert_equal "101", img["width"]
  end

  def test_lazy_option_overrides_default_config
    Lazyload::Rails.configure do |config|
      config.lazy_by_default = true
    end

    img = parse(image_tag("foo.png", size: "101x151", lazy: false))

    assert_nil img["data-original"]
    assert_match %r(^.*foo.png$), img["src"]
  end

  def test_lazy_attrs_override_conflicting_attributes
    conflicting_opts = { data: { original: "foo.png" } } # because the gem sets data-original

    img = parse(image_tag("notfoo.png", conflicting_opts.merge(size: "200x150", lazy: true)))

    assert_match %r(^.*notfoo.png$), img["data-original"]
  end

  def test_custom_placeholder_is_used_instead_of_normal_src
    Lazyload::Rails.configure do |config|
      config.placeholder = "/public/img/grey.gif"
    end

    img = parse(image_tag("baz.png", size: "100x250", lazy: true))

    assert_equal "/public/img/grey.gif", img["src"]
    assert_match %r(^.*baz.png$), img["data-original"]
  end

  def test_nonlazy_attributes_can_be_set
    [
      { size: "100x150", lazy: false },
      { size: "100x150" }
    ].each do |opts|
      img = parse(image_tag("foo.png", size: "100x150", lazy: false))
      assert_equal "150", img["height"]
      assert_equal "100", img["width"]
    end
  end

  def test_empty_options_return_nonlazy_img
    img = parse(image_tag("foo.png"))

    assert_nil img["data-original"]
    assert_match %r(^.*foo.png$), img["src"]
  end

  private

  def parse(image_html)
    Nokogiri::HTML::DocumentFragment.parse(image_html).at_css("img")
  end

  attr_reader :request

  def backwards_compatibility_setup
    unless defined? ActionView::VERSION
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
  end
end

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
