class AddCategoryIdToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :category_id, :integer
  end
end
