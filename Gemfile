source 'https://rubygems.org'

gem 'rails', '4.2.1' # Ruby on Rails version 4.2.1
gem 'pg'             # PostgreSQL database
gem 'turbolinks'     # Replace page requests with injection of <body> element
gem 'devise'         # User authentication helper
gem 'jbuilder'       # Domain Specific Language for writing JSON structures
gem 'sass-rails'     # Sass precompiler/ CSS compressor
gem 'uglifier'       # JavaScript compressor
gem 'coffee-rails'   # CoffeeScript precompiler; more Ruby-like JS

gem 'rails_12factor', group: :production # Necessary for Heroku deployment


group :development do     # Check multiple code quality indicators
  gem 'spring'         # Keep app running and updated while running tasks
  gem 'pry-rails'      # Use pry as rails console
  gem 'better_errors'  # More detailed crash reporting
    gem 'rack-mini-profiler'       # Time application response
  gem 'bullet'                   # Analyze database interactions (N+1 query)
  gem "rubycritic"               # Multiple quality metrics at a glance
  gem 'rails_best_practices'     # Check for indicators of poor design
  gem 'rubocop'                  # Check for style guideline compliance
  gem 'brakeman'                 # Check for security issues
  gem 'traceroute'               # Check for dead/ unused routes
  gem 'colored'                  # Color support for CLI (deadweight dependency)
  gem 'deadweight', :require => 'deadweight/hijack/rails' # Check for duplicate CSS selectors
end
group :doc do        # Aid in creating proper documentation
  gem 'sdoc'                     # Generate HTML annotations
  gem 'annotate'                 # Annotate models etc. based on schema
  gem 'rails-erd'                # Create ERDs from models
end