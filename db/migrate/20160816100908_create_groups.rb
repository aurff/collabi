class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :title
      t.text :description
      t.string :owner
      t.integer :maxMember
      t.string :university
      t.string :course
      t.string :term

      t.timestamps
    end
  end
end
