class User < ApplicationRecord
    has_secure_password
    
    has_many :tasks, as: :assignee, dependent: :nullify
    
    has_many :orders, dependent: :nullify
    has_many :comments, as: :commentable, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { password.present? }

    scope :with_orders, -> { includes(:orders) }
    scope :with_tasks, -> { includes(:tasks) }
end
