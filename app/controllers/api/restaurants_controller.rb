class Api::RestaurantsController < ApplicationController

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

    @begin_lat = response.parse["results"][0]["geometry"]["location"]["lat"]
    @begin_lng = response.parse["results"][0]["geometry"]["location"]["lng"]

    keyword = params[:keyword]
    distance = params[:distance]
    minprice = params[:minprice]
    maxprice = params[:maxprice]

    restaurant = HTTP.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@begin_lat},#{@begin_lng}&radius=#{distance}&type=restaurant&keyword=#{keyword}&minprice=#{minprice}&maxprice=#{maxprice}&openNow=true&key=#{ENV["GOOGLE_API_KEY"]}").parse["results"].to_a.sample

    @resturant_name = restaurant["name"]
    @resturant_address = restaurant["vicinity"]

    @end_lat = restaurant["geometry"]["location"]["lat"]
    @end_lng = restaurant["geometry"]["location"]["lng"]

    render 'index.json.jbuilder'
  end
end
