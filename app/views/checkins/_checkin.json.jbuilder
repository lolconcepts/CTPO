json.extract! checkin, :id, :user_id, :created_at, :updated_at
json.url checkin_url(checkin, format: :json)
