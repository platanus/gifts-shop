ActiveAdmin.register Store do
  permit_params :email, :password, :name, :region_id, :website,
                :facebook, :instagram, :twitter

  filter :name
  filter :email

  index do
    id_column
    column :name
    column :email
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :region
      f.input :website
      f.input :facebook
      f.input :instagram
      f.input :twitter
    end
    f.actions
  end
end
