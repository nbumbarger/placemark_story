ruby '2.2.0'
source 'https://rubygems.org'

gem 'rails'          # Ruby on Rails
gem 'pg'             # PostgreSQL database
gem 'turbolinks'     # Replace page requests with injection of <body> element
gem 'rails_12factor', group: :production # Necessary for Heroku deployment
gem 'devise'         # User authentication helper
gem 'sass-rails'     # Sass precompiler/ CSS compressor
gem 'uglifier'       # JavaScript compressor
gem 'puma'           # Web server

group :development do
  # Basic debugging
  gem 'spring'               # Keep app running and updated while running tasks
  gem 'pry-rails'            # Use pry as rails console
  gem 'better_errors'        # More detailed crash reporting
  # Performance analysis
  gem 'rack-mini-profiler'   # Time application response
  gem 'bullet'               # Analyze database interactions (N+1 query)
  # Quality analysis
  gem "rubycritic"           # Multiple quality metrics at a glance
  gem 'rails_best_practices' # Check for indicators of poor design
  gem 'rubocop'              # Check for style guideline compliance
  gem 'brakeman'             # Check for security issues
  gem 'traceroute'           # Check for dead/ unused routes
  gem 'colored'              # Color support for CLI (deadweight dependency)
  gem 'deadweight', :require => 'deadweight/hijack/rails' # Check for duplicate CSS selectors
end
group :doc do
  gem 'sdoc'                 # Generate HTML annotations
  gem 'annotate'             # Annotate models etc. based on schema
  gem 'rails-erd'            # Create ERDs from models
end