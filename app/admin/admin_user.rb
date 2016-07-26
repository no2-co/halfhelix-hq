ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  filter :email
  filter :last_sign_in_at

  index do
    selectable_column
    id_column
    column :email
    column "Last Sign in", :last_sign_in_at
    actions
  end

  show :title => :email do
    attributes_table :email, :last_sign_in_at, :created_at
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :admin
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
