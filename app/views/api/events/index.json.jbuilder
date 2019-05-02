json.name @event["name"]
json.localDate @event["dates"]["start"]["localDate"].to_date.strftime('%b %d, %Y')
json.localTime  @event["dates"]["start"]["localTime"].to_time.strftime('%I:%M:%S %p')
json.venue @event["_embedded"]["venues"][0]["name"]
json.address @event["_embedded"]["venues"][0]["address"]["line1"]
if @event["priceRanges"]
  json.minPrice @event["priceRanges"][0]["min"]
  json.maxPrice @event["priceRanges"][0]["max"]
end
json.url @event["url"]

# json.event @event