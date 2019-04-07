json.name @event["name"]
json.dateTime @event["dates"]["start"]["dateTime"]
json.venue @event["_embedded"]["venues"][0]["name"]
json.priceRange @event["priceRanges"][0]

# json.event @event