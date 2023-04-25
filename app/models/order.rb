class Order < ApplicationRecord
   belongs_to :user
   has_many :line_item, dependent: :destroy
   accepts_nested_attributes_for :line_item
 
end
