class Api::EventsController < ApplicationController
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

    response = HTTP.get("https://app.ticketmaster.com/discovery/v2/events.json?latlong=#{lat},#{long}&radius=#{radius}&units=km&apikey=#{ENV["TICKETMASTER_API_KEY"]}")

    render json: response.parse.to_a[0][1]["events"].sample
  end
end
