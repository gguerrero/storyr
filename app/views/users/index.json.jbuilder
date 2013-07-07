json.array!(@users) do |user|
  json.extract! user, :name, :email, :fullname, :admin, :created_at, :updated_at
  json.url user_url(user, format: :json)
end