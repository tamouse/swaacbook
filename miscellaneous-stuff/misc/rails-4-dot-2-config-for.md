
# Table of Contents

1.  [Rails 4.2 config<sub>for</sub>](#orgb1828ec)
    1.  [A common Rails idiom](#orge888458)
        1.  [`config/app_config.yml`](#org41ea48f)
        2.  [`config/initializers/app_config.rb`](#org3a1c4d7)
    2.  [Enter `config_for` at Rails 4.2](#org69adc02)
        1.  [`config/initializers/app_config.rb`](#org06d09b3)
    3.  [Example](#org777347d)


<a id="orgb1828ec"></a>

# Rails 4.2 config<sub>for</sub>

-   published date: 2015-01-20 07:30
-   keywords: ["configuration", "rails", "swaac"]

There have been a lot of blog posts and articles written on how to add application-specific configurations to a Rails app. In version 4.2, there is a method called `config_for` which makes a lot of that obsolete, simplifying the results.


<a id="orge888458"></a>

## A common Rails idiom

A seemingly very common idiom is to arrange appliation configuration values in YAML+ERB files under the `config` directory in a Rails app. Then, in an initializer, read in the file, process it through ERB, then YAML extract the set appropriate to the running environment, and save it in a constant or global:


<a id="org41ea48f"></a>

### `config/app_config.yml`

    default: &default
      service_url: https://my_service.example.com
    
    development:
      <<: *default
    
    test:
      <<: *default
    
    production:
      service_url: <%= ENV['APP_SERVICE_URL'] %>


<a id="org3a1c4d7"></a>

### `config/initializers/app_config.rb`

    require 'yaml'
    require 'erb'
    
    APP_CONFIG = YAML.load(ERB.new(File.read(Rails.root.join('config','app_config.yml'))).result)[Rails.env] || {}


<a id="org69adc02"></a>

## Enter `config_for` at Rails 4.2

[`config_for`](http://api.rubyonrails.org/classes/Rails/Application.html#method-i-config_for) is a method on `Rails.application`. It can be called bar within all the normal configuration contexts, such as inside `config/environments/development.rb` and such.

What it does is fairly straightforward, reading a YAML+ERB file from the `config` directory, returning the appropriate section based on the current Rails environment.

It's a simple enough implementation: <https://github.com/rails/rails/blob/1d1239d32856b32b19c04edd17d0dd0d47611586/railties/lib/rails/application.rb#L226> (Note of course this is a volatile link). It's implemented in Rails::Application#config<sub>for</sub>.

You pass in a symbol that corresponds to a file name under `config`, so `config_for(:app_config)` loads up the appropriate environment variables from `config/app_config.yml`.

Now, your initializer can become simply:


<a id="org06d09b3"></a>

### `config/initializers/app_config.rb`

    APP_CONFIG = Rails.application.config_for(:app_config)


<a id="org777347d"></a>

## Example

I've an example github repo at <https://github.com/tamouse/test_config_for>. Feel free to fork it and play with it yourself.

