class Consultation < ApplicationRecord
    has_many :user_events
    has_many :users, through: :user_events
    

    validates :title, presence: true
    validates :description, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :code, presence: true
    scope :waiting_for_approval, -> (user_id) {where(status: false, user_id: user_id)}

    def add_user_event(code)

        consult = Consultation.find_or_initialize_by(code: code)
        puts "hi"
        UserEvent.new(user_id: user_id, consultation_id: consult.id)

    end
end
