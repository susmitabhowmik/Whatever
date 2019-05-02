class Api::Events2Controller < ApplicationController
  def index
    address = params[:address]
    modified_address = ""
    i = 0
    address.length.times do 
      if address[i] == " "
        modified_address += "+"
      else
        modified_address += address[i]
      end
      i += 1
    end

    latlong = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{modified_address}&key=#{ENV["GOOGLE_API_KEY"]}")

    lat = latlong.parse["results"][0]["geometry"]["location"]["lat"]
    long = latlong.parse["results"][0]["geometry"]["location"]["lng"]

    radius = params[:radius]
    startDateTime = params[:startDateTime] #2019-04-10T00:00:00Z
    endDateTime = params[:endDateTime]


    @response = HTTP.get("https://www.eventbriteapi.com/v3/events/search/?location.latitude=#{lat}&location.longitude=#{long}&location.within=#{radius}mi&start_date.range_start=#{startDateTime}:00Z&start_date.range_end=#{endDateTime}:00Z&token=#{ENV["EVENTBRITE_API_KEY"]}").parse["events"].to_a.sample

   
    @venue = HTTP.get("https://www.eventbriteapi.com/v3/venues/#{@response["venue_id"]}/?token=#{ENV["EVENTBRITE_API_KEY"]}").parse["address"]["localized_address_display"]

    @start_time = @response["start"]["local"].to_date.strftime('%A, %d %b %Y %l:%M %p')
    @end_time = @response["end"]["local"].to_date.strftime('%A, %d %b %Y %l:%M %p')

    render 'index.json.jbuilder'
  end
end
