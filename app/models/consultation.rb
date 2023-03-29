class Consultation < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :code, presence: true
end
