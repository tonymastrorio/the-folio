class AddNameToPortfolio < ActiveRecord::Migration[5.1]
  def change
    add_column :portfolios, :name, :string
  end
end
