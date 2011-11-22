ActiveAdmin.register AdminUser do
  index do
    column :id
    column :email
    column :created_at
    default_actions
  end
  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
