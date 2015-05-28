# Placemark Story
## What it is
This application facilitates the effortless creation of placemark/ content-balloon style informational slippy maps. Creating a shareable map is as simple as defining a series of event locations through the interactive, geocoding-enabled map display, and giving them additional attributes as desired (detailed descriptions, images, and hyperlinks are supported). Placemark Story leverages the [Mapbox.js API](https://www.mapbox.com/mapbox.js/api/v2.1.9/) to transform your story into an interactive map, and stores it ready-to-share in your own personalized gallery.

##Who is it for?
*Anyone who has ever wanted to tell a story or present information spatially!* It has never been easier to create map stories, and even technically minded individuals who are familiar with the Mapbox.js library will find this application to be the fastest way to generate Mapbox-enabled markup for their custom projects.
-   Want to show off the pictures you took on your latest hike?
-   Show your guests the event locations at your wedding?
-   Are you a student who wants to present information and pictures about ancient Greek monuments for your school report?
-   Are you a foodie who wants to talk about the best cheesesteak places in Philadelphia?
-   Are you a journalist who wants to include a spatial-timeline of the robbery you reported on, to add even more excitement to your latest online article?

####Add spatial context to your story with Placemark Story!

##What's next?
Rich customization options for maps (basemap selection, data presentation options, per-placemark zoom settings etc.), design improvements, and social sharing features are the current priorities for this project.

##How can I help?
Get involved in the project by cloning the repository, adding your changes and submitting a pull request. Or start your own branch! Placemark story is a Ruby on Rails project and require some familiarity with [JavaScript](http://www.w3schools.com/js/), [Ruby](https://www.ruby-lang.org/en/documentation/), and the [Rails](http://rubyonrails.org/download/) framework to understand.
####Installation:
```sh
-   git clone git@github.com:nbumbarger/placemark_story.git #clone project
-   cd placemark_story #move to project directory
-   bundle install #install project dependencies
-   rake db:drop db:create db:migrate #initialize database
-   rake db:seed #(to load example data)
```
**Happy coding!**
