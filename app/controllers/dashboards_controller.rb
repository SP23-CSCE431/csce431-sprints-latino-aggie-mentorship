class DashboardsController < ApplicationController
  def show
    if current_admin.admin?
      render "dashboards/admin/admin"
    elsif current_admin.mentor?
      render "dashboards/mentor/mentor"
    elsif current_admin.mentee?
      render "dashboards/mentee/mentee"
    else
      render "dashboards/guest/guest"
    end
  end
end
