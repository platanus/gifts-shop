ActiveAdmin.register Product do
  menu parent: I18n.t('activeadmin.titles.stores')

  permit_params :store_id, :name, :category_id, :price, :description,
                :link, :email, :status, :promoted

  filter :name
  filter :store
  filter :category
  filter :price
  filter :price_interval
  filter :link
  filter :created_at
  filter :status, as: :select
  filter :promoted

  index do
    id_column
    column :store
    column :name
    column :category
    column :price
    column :price_interval
    column :link
    column :email
    column :clicks
    column :created_at
    column :status
    column :promoted
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
      update_status
    end

    private

    def update_image
      @product.update_image(params[:product][:image]) if params[:product][:image].present?
    end

    def update_status
      @product.approve! if :status == 'approved'
      @product.reject! if :status == 'rejected'
    end
  end

  show do
    attributes_table do
      row :store
      row :name
      row :category
      row :price
      row :price_interval
      row :description
      row :clicks
      row :link
      row :email
      row :image do |product|
        if product.image.attached?
          image_tag(url_for(product.image), size: 250, class: "aa-product__image")
        end
      end
      row :created_at
      row :updated_at
      row :deleted
      row :status
      row :promoted
    end
  end

  form do |f|
    f.inputs do
      f.input :store
      f.input :name
      f.input :category
      f.input :price
      f.input :description
      f.input :link
      f.input :email
      f.input :image, as: :file, hint: image_hint(f.object.image)
      f.input :status, as: :select, collection: product.aasm.states(permitted: true).map(&:name)
      f.input :promoted
    end
    f.actions
  end
end
