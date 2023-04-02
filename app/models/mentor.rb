class Mentor < ApplicationRecord
    belongs_to :user
    validates :email, presence: true, uniqueness: true
  
    def self.from_omniauth(auth)
      where(email: auth.info.email).first do |user|
        user.email = auth.info.email
        # other user attributes may be set here
      end
    end
end