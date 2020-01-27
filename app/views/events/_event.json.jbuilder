json.extract! event, :id, :description, :cost, :when, :created_at, :updated_at
json.url event_url(event, format: :json)
