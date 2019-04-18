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


    @response = HTTP.get("https://www.eventbriteapi.com/v3/events/search/?location.latitude=#{lat}&location.longitude=#{long}&location.within=#{radius}mi&start_date.keyword=today&token=#{ENV["EVENTBRITE_API_KEY"]}").parse["events"].to_a.sample

    @venue = HTTP.get("https://www.eventbriteapi.com/v3/venues/#{@response["venue_id"]}/?token=#{ENV["EVENTBRITE_API_KEY"]}").parse["address"]["localized_address_display"]

    render 'index.json.jbuilder'
  end
end
