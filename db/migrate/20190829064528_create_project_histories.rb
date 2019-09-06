class CreateProjectHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :project_histories do |t|
      t.reference :history
      t.reference :project
      t.timestamps
    end
  end
end
