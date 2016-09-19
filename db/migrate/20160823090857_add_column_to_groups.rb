class AddColumnToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :user, :string, default: ''
    add_column :groups, :location, :string, default: ''
    add_column :groups, :time, :string, default: ''
  end
end
