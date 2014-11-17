require "nokogiri"
require "action_view"

require "lazyload-rails/version"
require "lazyload-rails/configuration"

module Lazyload
  module Rails

    def self.configuration
      @configuration ||= Lazyload::Rails::Configuration.new
    end

    def self.configuration=(new_configuration)
      @configuration = new_configuration
    end

    # Yields the global configuration to a block.
    #
    # Example:
    #   Lazyload::Rails.configure do |config|
    #     config.placeholder = '/public/images/foo.gif'
    #   end
    def self.configure
      yield configuration if block_given?
    end

    def self.reset
      @configuration = nil
    end
  end
end

ActionView::Helpers::AssetTagHelper.module_eval do
  alias :rails_image_tag :image_tag

  def image_tag(*attrs)
    options, args = extract_options_and_args(*attrs)
    image_html = rails_image_tag(*args)

    if options[:lazy]
      to_lazy_image(image_html)
    else
      image_html
    end
  end

  private

  def to_lazy_image(image_html)
    img = Nokogiri::HTML::DocumentFragment.parse(image_html).at_css("img")

    img["data-original"] = img["src"]
    img["src"] = Lazyload::Rails.configuration.placeholder

    img.to_s.html_safe
  end

  def extract_options_and_args(*attrs)
    args = attrs

    if args.size > 1
      options = attrs.last.dup
      args.last.delete(:lazy)
    else
      options = {}
    end

    [options, args]
  end

end
