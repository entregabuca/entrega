json.extract! sender, :id, :name, :telephone, :email, :address, :latitude, :longitude, :status, :created_at, :updated_at
json.url sender_url(sender, format: :json)
