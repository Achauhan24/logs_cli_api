json.users do
  json.partial! 'user', collection: @users, as: :user
end

json.meta do
  json.total_pages @users.total_pages
end