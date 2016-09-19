class RemoveColumnFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :owner
  end
end
