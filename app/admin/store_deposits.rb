ActiveAdmin.register Deposit do
  menu parent: I18n.t('activeadmin.titles.stores')

  permit_params :store_id, :amount, :organization_id

  index do
    id_column
    column :store
    column :organization
    column :amount
  end

  form do |f|
    f.object.organization ||= Organization.find_by(name: 'Platanus')

    f.inputs do
      f.input :store
      f.input :organization
      f.input :amount
    end
    f.actions
  end
end
