class User < ApplicationRecord
    validates :name, presence: true
    validates :status, presence: true
    validates :year, presence: true
end
