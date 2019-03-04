json.extract! company, :id, :name, :telephone, :email, :address, :latitude, :longitude, :radius, :status, :created_at, :updated_at
json.url company_url(company, format: :json)
