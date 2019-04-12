# -*- coding: utf-8 -*-
module Lazyload
  module Rails

    # Stores runtime configuration information.
    #
    # Example settings
    #   Lazyload::Rails.configure do |c|
    #     c.placeholder  = "/public/img/grey.gif"
    #   end
    class Configuration

      # The placeholder image to put into the img src attribute
      # (default: 1×1 pixel grey gif at
      # "http://www.appelsiini.net/projects/lazyload/img/grey.gif").
      def placeholder
        @placeholder
      end
      def placeholder=(new_placeholder)
        @placeholder = new_placeholder
      end

      # When set to true every image_tag will include { lazy: true } by default
      def lazy_by_default=(lazy_by_default)
        @lazy_by_default = !!lazy_by_default
      end
      def lazy_by_default
        @lazy_by_default
      end

      # Set default settings
      def initialize
        @placeholder = "data:image/gif;base64,R0lGODdhAQABAPAAAMPDwwAAACwAAAAAAQABAAACAkQBADs="
        @lazy_by_default = false
      end
    end
  end
end
