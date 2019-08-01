class AddReferencesProjectHistory < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_histories, :project, index: true
    add_reference :project_histories, :history, index: true
  end
end
