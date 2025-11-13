class User < ApplicationRecord
    has_secure_password
    
    has_many :orders, dependent: :nullify
    has_many :comments, as: :commentable, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :name, presence: true

    scope :with_orders, -> { includes(:orders) }
end
