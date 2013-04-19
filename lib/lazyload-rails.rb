require "nokogiri"
require "action_view"
require "lazyload-rails/version"

ActionView::Helpers::AssetTagHelper.module_eval do
  alias :x_image_tag :image_tag

  def image_tag(*attrs)
    placeholder = "http://www.appelsiini.net/projects/lazyload/img/grey.gif"
    img = Nokogiri::HTML::DocumentFragment.parse(x_image_tag(*attrs)).at_css("img")
    src = img["src"]

    img["src"] = placeholder
    img["data-original"] = src
    img.to_s.html_safe
  end
end
