class PagesController < ApplicationController
  def calendar
    @consultations = Consultation.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    )
    if current_admin.admin?
      render "calendar"
    else
      render "member_calendar"
    end
  end

  # def member_calendar
  #   @consultations = Consultation.where(
  #     start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
  #   )
  # end
end
