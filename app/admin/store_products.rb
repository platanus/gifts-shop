ActiveAdmin.register Product do
  menu parent: I18n.t('activeadmin.titles.stores')

  permit_params :store, :name, :price, :link

  filter :name
  filter :store
  filter :price
  filter :link

  index do
    id_column
    column :store
    column :name
    column :price
    column :link
    column :promoted
    column :display
  end

  form do |f|
    f.inputs do
      f.input :store
      f.input :name
      f.input :price
      f.input :link
    end
    f.actions
  end
end
