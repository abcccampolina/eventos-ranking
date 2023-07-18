json.extract! manage_user, :id, :name, :email, :created_at, :updated_at
json.url manage_user_url(manage_user, format: :json)
