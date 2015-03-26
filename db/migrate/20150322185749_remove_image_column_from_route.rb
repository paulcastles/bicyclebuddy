class RemoveImageColumnFromRoute < ActiveRecord::Migration
  def change
    remove_column :Routes, :image
  end
end
