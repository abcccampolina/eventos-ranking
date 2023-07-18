json.set! :data do
  json.array! @manage_users do |manage_user|
    json.partial! 'manage_users/manage_user', manage_user: manage_user
    json.url  "
              #{link_to 'Show', manage_user }
              #{link_to 'Edit', edit_manage_user_path(manage_user)}
              #{link_to 'Destroy', manage_user, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end