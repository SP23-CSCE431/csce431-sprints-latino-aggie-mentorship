class UserEvent < ApplicationRecord
    belongs_to :consultation
    belongs_to :user
    
    validates :consultation_id, uniqueness: { scope: :user_id, message: "has already been attended by this user." }
end
