class Route < ActiveRecord::Base
  serialize :points
  belongs_to :category
  has_many :comments
  has_many :favourites
  
end
