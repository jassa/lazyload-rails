## Lazyload-Rails

The lazyload-rails project integrates jQuery Lazy Load Plugin
for Rails image_tag helpers

## Features

* Automatically get Rails `image_tag` helper to render lazyload-friendly image tags.

Simple, that's pretty much it, really.

## Example

    <%= image_tag "kittenz.png", alt: "OMG a cat!" %>

Equals:

    <img alt="OMG a cat!" data-original="/images/kittenz.png" src="http://www.appelsiini.net/projects/lazyload/img/grey.gif">

## Installation

Add this line to your application's Gemfile:

  gem "lazyload-rails"

Download [jQuery Lazy Load](https://raw.github.com/tuupola/jquery_lazyload/master/jquery.lazyload.js) into your `vendor/assets/javascripts` directory and include it however you prefer.

Important: Remember that the Lazy Load Plugin depends on jQuery.

## License

Lazyload-Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
