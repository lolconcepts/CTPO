json.extract! volunteer, :id, :name, :phone, :email, :note, :created_at, :updated_at
json.url volunteer_url(volunteer, format: :json)
