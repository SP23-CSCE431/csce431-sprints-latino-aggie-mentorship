class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless email =~ /@tamu.edu\z/
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end

  # called in dashboards_controller.rb, returns true/false based on role
  def admin?
    role == "Admin"
  end
  def mentor?
    role == "Mentor"
  end
  def mentee?
    role == "Mentee"
  end
end