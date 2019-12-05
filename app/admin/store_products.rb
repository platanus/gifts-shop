ActiveAdmin.register Product do
  menu parent: I18n.t('activeadmin.titles.stores')

  permit_params :store, :name, :price, :link, :promoted, :display, :gender, :age, :novelty, :image

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

  show do
    attributes_table do
      row :name
      row :price
      row :clicks
      row :link
      row :image do |product|
        image_tag(url_for(product.image)) if product.image.attached?
      end
      row :clicks_cost
      row :store
      row :created_at
      row :updated_at
      row :display
      row :promoted
      row :deleted
      row :average_color
      row :gender
      row :age
      row :novelty
    end
  end

  form do |f|
    f.inputs do
      f.input :store
      f.input :name
      f.input :price
      f.input :link
      image = f.object.image
      hint = image.attached? ? image_tag(url_for(image)) : content_tag(:span, "Sin imagen")
      f.input :image, as: :file, hint: hint
      f.input :promoted
      f.input :display
      f.input :gender
      f.input :age
      f.input :novelty
    end
    f.actions
  end
end
