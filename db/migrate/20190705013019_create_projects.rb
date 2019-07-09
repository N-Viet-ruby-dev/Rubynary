class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.text :name
      t.string :color_code

      t.timestamps
    end
  end
end
