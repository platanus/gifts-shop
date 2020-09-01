class CreateDefaultStore < ActiveRecord::Migration[5.2]
  def up
    Store.create(region_id: 1, name: 'Tienda Platanus', email: 'contacto@platan.us', password: '12345678', password_confirmation: '12345678')
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
