class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :ja
      t.string :en
      t.string :vi
      t.integer :created_by_id
      t.integer :last_update_by_id
      t.text :description

      t.timestamps
    end
  end
end
