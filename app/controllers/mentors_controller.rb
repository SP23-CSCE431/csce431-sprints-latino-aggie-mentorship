class MentorsController < ApplicationController
  before_action :set_user, only: %i[ index edit update destroy ]
  # def index
  #   @mentors = Mentor.all
  # end
  def new
      @mentors = Mentor.new
  end

  def index
      main = Main.new(:name => 1, :hours => 0)
      main.save
  end

#   def create
#       render text: params[:post].inspect
#   end
  def user_params
    params.require(:user).permit(:name, :hour)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end


  # Uses the name of the logged in user to to find their associated user_id
  def find_by_name
      @user = User.find_by(user_name: params[:user_name])
      if @user.present?
        @mentor = @user.mentor
      else
        flash[:error] = "User not found"
        redirect_to root_path
      end
  end

  def update
      @mentor = Mentor.find(params[:mentor_id])
      @mentor.update(hours: params[:mentor_id][:hours])
      redirect_to @mentor
  end
  
  # Uses the user_id to get the associated mentor_id and increment that mentor's hours
  def increment_hours
      @mentor = Mentor.find(params[:mentor_id]) #id
      hours_to_add = instance.increment!(@mentor.hours, :hours) #params[:hours].to_i
      @mentor.hours += hours_to_add
      if @mentor.save
          flash[:success] = "#{hours_to_add} hours added"
      else
          flash[:error] = "Failed to add hours"
      end
      redirect_to root_path
  end

  # def update
  #     mentor = Mentor.find(params[:id])
  #     hours = params[:hours].to_i
  #     user = User.find(params[:user_id])
  
  #     if mentor.update(hours: mentor.hours + hours)
  #       flash[:success] = "#{user.name} has tutored #{mentor.name} for #{hours} hours."
  #       redirect_to mentor_path(mentor)
  #     else
  #       flash[:error] = "Failed to update hours."
  #       redirect_to mentor_path(mentor)
  #     end
  # end
end
