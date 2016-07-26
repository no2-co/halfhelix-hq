ActiveAdmin.register Organization do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :business_phone, :city, :country, :fax, :name, :state, :street_1, :street_2, :zip_code

  index do
    column :name
    column :business_phone
    actions
  end

  filter :name

  form do |f|
    f.inputs "Client" do
      f.input :name
      f.input :street_1
      f.input :street_2
      f.input :city
      f.input :state
      f.input :zip_code
      f.input :business_phone
    end
    actions
  end


end
