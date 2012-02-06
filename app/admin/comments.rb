ActiveAdmin.register Comment, :as => "ClientComment" do

  index do
    column :id
    column :user_name
    column :email
    column :created_at
    column :updated_at

    default_actions
  end

end
