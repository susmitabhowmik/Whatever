class Api::MapsController < ApplicationController
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

    p modified_address
    response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{modified_address}&key=#{ENV["GOOGLE_API_KEY"]}")

    @lat = response.parse["results"][0]["geometry"]["location"]["lat"]
    @lng = response.parse["results"][0]["geometry"]["location"]["lng"]

    render 'index.json.jbuilder'

  end
end
