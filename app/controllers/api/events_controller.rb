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

    city = params[:city]
    state = params[:state]
    start_date = params[:start_date] #2019-04-10T00:00:00Z
    end_date = params[:end_date]
    keyword= params[:keyword]
    radius = params[:radius]

    response = HTTP.get("https://app.ticketmaster.com/discovery/v2/events.json?&page=#{rand(1...10)}&latlong=#{lat},#{long}&radius=#{radius}&units=miles&apikey=#{ENV["TICKETMASTER_API_KEY"]}")

    @event = response.parse.to_a[0][1]["events"].sample
    render 'index.json.jbuilder'
  end
end
