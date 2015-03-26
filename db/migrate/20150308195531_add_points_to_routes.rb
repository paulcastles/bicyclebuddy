class AddPointsToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :points, :text
  end
end
