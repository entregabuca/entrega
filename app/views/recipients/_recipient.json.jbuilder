json.extract! recipient, :id, :name, :telephone, :email, :order_id, :created_at, :updated_at
json.url recipient_url(recipient, format: :json)
