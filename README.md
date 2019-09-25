# Whatever

Whatever is an application for indecisive people created using Ruby on Rails for the backend and Vue.js for the frontend. Whatever helps you decide on where to eat and what to do. It helps you choose a local event or a major event to attend in your area. You can filter the choices the app makes for you via parameters such as price, date, and time.  Whatever is the perfect app to help you plan a weekend getaway or even to discover new things near you.

###Prerequisites

Rails 5.2.2.1
ruby 2.6.1

###Installing 

To clone the application, run the following command in your command line.

`git clone https://github.com/susmitabhowmik/Whatever.git`

Once you clone the app, run `bundle install` in terminal to ensure the installation of gems.

Then run `rails -s` to start up rails server, Afterwards, navigate to localhost:3000.

At this point, you should be able to see the home page for Whatever. 

###Important Information

Please note that you need to have API keys for Google Maps, Ticketmaster, and Eventbrite for this application to work locally. 

To add in your API key, navigate to the application.yml file.

Add API keys in the following formats :

GOOGLE_API_KEY: api_key_here
TICKETMASTER_API_KEY: api_key_here
EVENTBRITE_API_KEY: api_key_here

###Using the application
* You must press the go button to retrieve data, and also use go to refresh.
* To find an event near you, both the date and time are required. Please ensure you specify AM or PM for the application to work correctly.
* You can utilize the map by manually typing in origin and destination addresses