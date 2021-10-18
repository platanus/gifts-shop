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

  show do
    attributes_table do
      row :email
      row :password
      row :name
      row :region_id
      row :website
      row :facebook
      row :instagram
      row :twitter
    end

    panel "Reporte de estadísticas general" do
      attributes_table_for store do
        row :total_products_clicks
      end
    end

    panel "Reporte de estadísticas de productos" do
      table_for store.products.order(clicks: :desc) do
        column :name
        column :clicks
      end
    end
  end
end
