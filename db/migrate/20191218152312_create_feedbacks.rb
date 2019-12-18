class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.references :receiver, foreign_key: true
      t.integer :response
      t.text :additional_info

      t.timestamps
    end
  end
end
