#Notes on installing various extensions into Rails asset pipeline:
    *The preferred and most secure way to add external libraries to Rails projects is to add them to the official asset pipeline, rather than simply linking to the associated js or css documents.
    *Better still is to use a gem to make manage the external library and make sure it stays up-to date.
    *This document lists the configuration steps required to include various libraries in this project.

#Normalize.css (loads a stylesheet which normalizes styles, by explicitly setting styles which are displayed differently across browsers)
*https://github.com/markmcconachie/normalize-rails
    *Add normalize.css manager to Gemfile:
        gem 'normalize-rails'
        *bundle install
    *Add normalize.css style to stylesheet asset pipeline (app/assets/stylesheets/application.css)
        *= require normalize-rails
        *= require_self
        *= require_tree .

#Mapbox.js (the mapbox javascript API and stylesheet)
*https://github.com/aai/mapbox-rails
    *Add mapbox manager to Gemfile
        gem 'mapbox-rails'
        *bundle install
    *Add mapbox to javascript asset pipeline (app/assets/javascripts/application.js)
        //= require mapbox.js
    *Add mapbox to stylesheet asset pipeline (app/assets/stylesheets/application.css)
        *= require mapbox
    *Add image precompilation (for mapbox icons) to asset initializer (config/initializers/assets.rb)
        Rails.application.config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif] 

