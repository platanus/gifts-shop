ActiveAdmin.register Product do
  menu parent: I18n.t('activeadmin.titles.stores')

  permit_params :store_id, :name, :price, :link, :promoted, :display, :gender, :age, :novelty

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

  controller do
    def create
      super
      update_image
    end

    def update
      super
      update_image
    end

    private

    def update_image
      @product.update_image(params[:product][:image]) if params[:product][:image].present?
    end
  end

  show do
    attributes_table do
      row :name
      row :price
      row :clicks
      row :link
      row :image do |product|
        if product.image.attached?
          image_tag(url_for(product.image), size: 250, class: "aa-product__image")
        end
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
      f.input :image, as: :file, hint: image_hint(f.object.image)
      f.input :promoted
      f.input :display
      f.input :gender
      f.input :age
      f.input :novelty
    end
    f.actions
  end
end
