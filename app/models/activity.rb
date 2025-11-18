class Activity < ApplicationRecord
    belongs_to :record, polymorphic: true
    
    validates :action, presence: true
end
