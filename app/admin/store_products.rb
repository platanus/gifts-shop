ActiveAdmin.register Product do
  menu parent: I18n.t('activeadmin.titles.stores')

  permit_params :store, :name, :price, :link, :promoted, :display, :gender, :age, :novelty

  filter :name
  filter :store
  filter :price
  filter :link
  filter :created_at

  index do
    id_column
    column :store
    column :name
    column :price
    column :link
    column :promoted
    column :display
    column :gender
    column :age
    column :novelty
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :store
      f.input :name
      f.input :price
      f.input :link
      f.input :promoted
      f.input :display
      f.input :gender
      f.input :age
      f.input :novelty
    end
    f.actions
  end
end
