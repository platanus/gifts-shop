ActiveAdmin.register Deposit do
  menu parent: I18n.t('activeadmin.titles.stores')

  permit_params :store_id, :amount, :organization_id, :deposit_time

  index do
    id_column
    column :store
    column :organization
    column :amount
    column(:deposit_time) { |d| d.deposit_time.to_datetime }
  end

  form do |f|
    f.object.organization ||= Organization.platanus
    f.object.deposit_time = Date.current

    f.inputs do
      f.input :store
      f.input :organization
      f.input :amount
      f.input(
        :deposit_time,
        as: :date_time_picker
      )
    end
    f.actions
  end
end
