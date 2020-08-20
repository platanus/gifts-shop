ActiveAdmin.register Category do
    menu parent: I18n.t('activeadmin.titles.stores')

    permit_params :name

    filter :name

    index do
      id_column
      column :name
      column :description
      actions
    end

    show do
      attributes_table do
        row :name
        row :description
      end
    end

    form do |f|
      f.inputs do
        f.input :name
        f.input :description
      end
      f.actions
    end
  end
