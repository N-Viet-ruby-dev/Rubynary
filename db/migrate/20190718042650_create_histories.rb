class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.string :keyword
      t.references :user

      t.timestamps
    end
  end
end
