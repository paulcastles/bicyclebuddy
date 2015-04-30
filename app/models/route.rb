class Route < ActiveRecord::Base
  serialize :points
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  
end
