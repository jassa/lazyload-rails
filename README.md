## Lazyload-Rails [![Build Status](https://travis-ci.org/jassa/lazyload-rails.png)](https://travis-ci.org/jassa/lazyload-rails)

This project integrates the jQuery Lazy Load Plugin
for Rails `image_tag` helpers

### What's jQuery Lazy Load?

From the project page:

*Lazy Load is a jQuery plugin written in JavaScript. It delays loading of images in long web pages. Images outside of viewport (visible part of web page) won't be loaded before user scrolls to them. This is opposite of image preloading.*

*Using Lazy Load on long web pages containing many large images makes the page load faster. Browser will be in ready state after loading visible images. In some cases it can also help to reduce server load.*

See [example](http://backbonejs.org/#examples) (scroll down to see images load)

## Documentation

### Features

* Add `lazy: true` option to Rails `image_tag` helpers to render lazyload-friendly img tags.
* Global config available to make them lazy by default.
* Simple (really). That's pretty much it.

### Example

```erb
<%= image_tag "kittenz.png", lazy: true %>
```

or

```ruby
# config/initializers/lazyload.rb
Lazyload::Rails.configure do |config|
  config.lazy_by_default = true
end
```
```erb
<%= image_tag "kittenz.png" %>
```

Equals:

```html
<img src="data:image/gif;base64,R0lGODdhAQABAPAAAMPDwwAAACwAAAAAAQABAAACAkQBADs="
     data-original="/images/kittenz.png" />
```

**PRO TIP!** You must set image dimensions either as width and height attributes or in CSS. Otherwise plugin might not work properly.

## Install

1. Add this line to your application's Gemfile:

        gem "lazyload-rails"

2. Download the [jQuery Lazy Load Plugin](https://raw.github.com/tuupola/jquery_lazyload/master/jquery.lazyload.js)
into your `vendor/assets/javascripts` directory.

3. Include it however you prefer. For example, in your application.js you could add:

        //= require jquery.lazyload

4. In your JavaScript code do:

        $("img").lazyload();

Lazy Load can be customized, [see more options](http://www.appelsiini.net/projects/lazyload)

*__Important__: Remember that the Lazy Load Plugin depends on jQuery.*

## Configuration

```ruby
# config/initializers/lazyload.rb
Lazyload::Rails.configure do |config|
  # By default, a 1x1 grey gif is used as placeholder ("data:image/gif;base64,...").
  # This can be easily customized:
  config.placeholder = "/public/img/grey.gif"

  # All lazyload images can have an additional classes added to them for easy DOM querying
  config.lazy_css_class = "lazy_images"

  # image_tag can return lazyload-friendly images by default,
  # no need to pass the { lazy: true } option
  config.lazy_by_default = true
end
```

## License

Lazyload-Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
