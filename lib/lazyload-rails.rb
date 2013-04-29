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
  alias :x_image_tag :image_tag

  def image_tag(*attrs)
    placeholder = Lazyload::Rails.configuration.placeholder
    img = Nokogiri::HTML::DocumentFragment.parse(x_image_tag(*attrs)).at_css("img")
    src = img["src"]

    img["src"] = placeholder
    img["data-original"] = src
    img.to_s.html_safe
  end
end
