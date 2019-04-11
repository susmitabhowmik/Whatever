json.name @event["name"]
json.dateTime @event["dates"]["start"]["dateTime"]
json.venue @event["_embedded"]["venues"][0]["name"]
json.address @event["_embedded"]["venues"][0]["address"]["line1"]
if @event["priceRanges"]
  json.priceRange @event["priceRanges"][0]
end

# json.event @event