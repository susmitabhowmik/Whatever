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

    response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{modified_address}&key=#{ENV["GOOGLE_API_KEY"]}")

    @lat = response.parse["results"][0]["geometry"]["location"]["lat"]
    @lng = response.parse["results"][0]["geometry"]["location"]["lng"]

    keyword = params[:keyword]

    restaurant = HTTP.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@lat},#{@lng}&radius=1609.34&type=restaurant&keyword=#{keyword}&key=#{ENV["GOOGLE_API_KEY"]}")


    @resturant_name = restaurant.parse["results"].to_a.sample["name"]
    @resturant_address = restaurant.parse["results"].to_a.sample["vicinity"]

    render 'index.json.jbuilder'
  end
end
