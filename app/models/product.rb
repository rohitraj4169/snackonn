class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :line_items

  extend FriendlyId
  friendly_id :name, use: :slugged



   def self.ransackable_attributes(auth_object = nil)
    ["category_id", "description", "id", "image", "name", "price", "status", "stock", "unit",  "weight"]
  end
  validates_presence_of :name,:description,:price,:weight,:stock,:unit,:status
end
