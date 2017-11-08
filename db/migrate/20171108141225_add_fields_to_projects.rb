class AddFieldsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :portfolio_id, :integer
    add_attachment :projects, :image
  end
end
