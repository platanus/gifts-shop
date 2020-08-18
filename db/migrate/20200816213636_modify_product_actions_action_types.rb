class ModifyProductActionsActionTypes < ActiveRecord::Migration[5.2]
  def up
    # Remove all like and dislike ProductActions
    ProductAction.where(action_type: [:like, :dislike]).destroy_all
  end
end
