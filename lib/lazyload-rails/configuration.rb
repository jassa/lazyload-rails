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

      # When set to true
      def always_lazy=(always_lazy_value)
        @always_lazy = always_lazy_value
      end
      def always_lazy
        @always_lazy
      end

      # Set default settings
      def initialize
        @placeholder = "http://www.appelsiini.net/projects/lazyload/img/grey.gif"
        @always_lazy = false
      end
    end
  end
end
