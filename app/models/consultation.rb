class Consultation < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true

    # has_many :user_events
    # has_many :users, through: :user_events

    has_and_belongs_to_many :users
end
