class CreateSuggestedWords < ActiveRecord::Migration[5.2]
  def change
    create_table :suggested_words do |t|
      t.integer :word_id
      t.string :ja
      t.string :en
      t.string :vi
      t.text :description
      t.integer :created_by_id
      t.integer :status

      t.timestamps
    end
  end
end
