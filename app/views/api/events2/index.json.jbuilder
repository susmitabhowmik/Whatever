json.event_name @response["name"]["text"]
json.description @response["description"]["text"]
json.start_time @response["start"]["local"].to_datetime.strftime('%A, %d %b %Y %l:%M %p')
json.end_time @response["end"]["local"].to_datetime.strftime('%A, %d %b %Y %l:%M %p')
json.venue @venue
json.url @response["url"]


# json.response @response