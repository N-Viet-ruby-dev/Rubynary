class CreateProjectWords < ActiveRecord::Migration[5.2]
  def change
    create_table :project_words do |t|
      t.integer :word_id
      t.integer :project_id

      t.timestamps
    end
  end
end
