## Lazyload-Rails

This project integrates the jQuery Lazy Load Plugin
for Rails `image_tag` helpers

## Documentation

### Features

* Automatically get Rails `image_tag` helpers to render lazyload-friendly
html img tags.
* Simple, really. That's pretty much it.

### Example

    <%= image_tag "kittenz.png", alt: "OMG a cat!" %>

Equals:

    <img alt="OMG a cat!" data-original="/images/kittenz.png" src="http://www.appelsiini.net/projects/lazyload/img/grey.gif">

## Install

Add this line to your application's Gemfile:

    gem "lazyload-rails"

Download the [jQuery Lazy Load Plugin](https://raw.github.com/tuupola/jquery_lazyload/master/jquery.lazyload.js)
into your `vendor/assets/javascripts` directory and include it however you prefer.

*Important: Remember that the Lazy Load Plugin depends on jQuery.*

## FAQ

* *Q: How can I use the old `image_tag` method?*
* R: Try with `x_image_tag`

## License

Lazyload-Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
