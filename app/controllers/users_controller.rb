class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def profile
    user = User.find_by(email: request.env['omniauth.auth']['info']['email'])
    @hours = user.hours if user.present?
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST
  def add_hours
    u1 = User.find_by(email:current_admin.email)
    if u1.increment!(:hour, params[:hours].to_i)
      u1.save
      flash[:success] = "Hours updated successfully."
    else
      flash[:error] = "Unable to update hours."
    end
    render "dashboards/mentor/mentor"
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    respond_to do |format|
      # Call the function in user.rb that could throw an error
      if @user.check_single_admin_destroy
        # If the function call succeeds, delete the user
        @user.destroy
        # Also delete the admin
        admin = Admin.find_by(email: @user.email)
        admin.destroy
        
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to user_url(@user), notice: "User could not be destroyed. There must be at least one admin user." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_string
    input_string = params[:input_string]
    @model = Consultation.where(code: input_string).first
  end
    
  # SEARCH users
  def search
    #Changed from @users = User.all in order to be able to show filtered users based on search term
    @users = search_helper(params[:search])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # function designed to handle searching for users based on entered search params
    def search_helper(search)
      arr = search&.split
      if arr
        arr[0] = arr[0].upcase
        #if only one 'word' is searched, then search all users for matching department
        if arr.length == 1
          # find all users where the input matches the department of a course they took
          found_users = User.joins(:courses).where(courses: {department: arr[0]})
          # if no users are found return all users, else return all found users
          if found_users.size.zero?
            respond_to do |format|
              format.html { redirect_to search_url, alert: "Error: No user found taking a course in " + arr[0] + "." }
            end
            found_users = User.where(role: "Mentor")
          else
            found_users = found_users.where(role: "Mentor")
          end
        # if two separate strings are searched, then search all users for specific course (ie 'CSCE 431')
        elsif arr.length == 2
          # find all users where the input matches the department of a course they took
          found_users = User.joins(:courses).where(courses: {department: arr[0], code: arr[1]})
          # if no users are found return all users, else return all found users
          if found_users.size.zero?
            respond_to do |format|
              format.html { redirect_to search_url, alert: "Error: No user found taking " + arr[0] + " " + arr[1] + "." }
            end
            found_users = User.where(role: "Mentor")
          else
            found_users = found_users.where(role: "Mentor")
          end
        else
          respond_to do |format|
            format.html { redirect_to search_url, alert: "Error: Invalid input. Please enter either a department or a course code." }
          end
          found_users = User.where(role: "Mentor")
        end
      else
        found_users = User.where(role: "Mentor")
      end
      User.where(id: found_users)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role, :year, :search, :points, :hour)
    end
end
