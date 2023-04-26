class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  validates :role, presence: true
  has_one :cart, dependent: :destroy
  has_many :orders
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length:{ maximum:105}, format: { with: VALID_EMAIL_REGEX }
  validates_presence_of :first_name, :last_name
  validates :phone_number,length:{minimum:10, maximum:10}
end
