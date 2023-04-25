class Category < ApplicationRecord
  belongs_to :parent_category, class_name: "Category", optional: true
  has_one_attached :image
  has_many :product

  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    [ "name"]
  end

end
