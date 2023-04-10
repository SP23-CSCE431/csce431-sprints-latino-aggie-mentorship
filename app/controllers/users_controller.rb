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
        format.html { redirect_to users_path, notice: "User was successfully created." }
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
        format.html { redirect_to users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET
  def log_hours
    respond_to do |format|
      format.html { render "dashboards/mentor/add_hours" }
    end
  end

  # POST
  def add_hours
    respond_to do |format|
      u1 = User.find_by(email:current_admin.email)
      if u1.increment!(:hour, params[:hours].to_i)
        u1.save
        format.html { redirect_to "/", notice: "Hours updated successfully." }
      else
        flash[:error] = "Unable to update hours."
      end
    end
  end

  def add_course
    add_course_helper(params[:course])
  end

  def add_hobby
    add_hobby_helper(params[:hobby])
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
    
  # SEARCH users by department or class
  def search
    #Changed from @users = User.all in order to be able to show filtered users based on search term
    @users = search_helper(params[:search])
  end

  # SEARCH users by hobby
  def search1
    #Changed from @users = User.all in order to be able to show filtered users based on search term
    @users = search1_helper(params[:search1])
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
        alert = ""
        #if only one 'word' is searched, then search all users for matching department
        if arr.length == 1
          # find all users where the input matches the department of a course they took
          found_users = User.joins(:courses).where(courses: {department: arr[0]})
          alert = "Error: No user found taking a course in " + arr[0] + "."
        # if two separate strings are searched, then search all users for specific course (ie 'CSCE 431')
        elsif arr.length == 2
          # find all users where the input matches the department of a course they took
          found_users = User.joins(:courses).where(courses: {department: arr[0], code: arr[1]})
          alert = "Error: No user found taking " + arr[0] + " " + arr[1] + "."
        else
          found_users = User.joins(:hobbies).where(hobbies: {name: search})
          alert = "Error: Invalid course code or hobby does not exist. Please check your search terms for spelling."
        end
        # check if there are no found users (then check if the search term is a hobby), else 
        if found_users.size.zero?
          found_users = User.joins(:hobbies).where(hobbies: {name: search})
          # if no users found with this hobby either, return all users and post alert
          if found_users.size.zero?
            respond_to do |format|
              format.html { redirect_to search_url, alert: alert }
            end
            found_users = User.where(role: "Mentor")
          else
            found_users = found_users.where(role: "Mentor")
          end
        else
          found_users = found_users.where(role: "Mentor")
        end
      else
        found_users = User.where(role: "Mentor")
      end
      User.where(id: found_users)
    end

    # function designed to handle adding a course to a mentor's profile
    def add_course_helper(course)
      arr = course&.split
      if arr
        arr[0] = arr[0].upcase
        #if two separate strings are submitted, then continue
        if arr.length == 2
          # check if course already exists in course database
          found_course = Course.find_by(department: arr[0], code: arr[1])
          # if a course is found, then update join table to assign that course to the current user
          if found_course
            u1 = User.find_by(email:current_admin.email)
            # check first if user already has that course in their profile
            check_exists = CourseUser.find_by(course_id: found_course.id, user_id: u1.id)
            if check_exists
              flash[:alert] = "Error: Course already exists in your profile."
              redirect_to "/add_course"
              return
            end
            CourseUser.create(course_id: found_course.id, user_id: u1.id, created_at: Time.now, updated_at: Time.now)
          # otherwise, add course to course database and then update join table to assign that course to the current user
          else
            Course.create(department: arr[0], code: arr[1], created_at: Time.now, updated_at: Time.now)
            u1 = User.find_by(email:current_admin.email)
            new_course = Course.find_by(department: arr[0], code: arr[1])
            CourseUser.create(course_id: new_course.id, user_id: u1.id, created_at: Time.now, updated_at: Time.now)
          end
          respond_to do |format|
            format.html { redirect_to "/add_course", notice: "Successfully added course to profile." }
          end
        #else if more or less than two strings are submitted, then there is an error
        else
          flash[:alert] = "Error: Invalid input. Please enter a valid course code."
          redirect_to "/add_course"
        end
      end
    end

    # function designed to handle adding a hobby to a mentor's profile
    def add_hobby_helper(hobby)
      if hobby
        # check if course already exists in course database
        found_hobby = Hobby.find_by(name: hobby)
        # if a course is found, then update join table to assign that course to the current user
        if found_hobby
          u1 = User.find_by(email: current_admin.email)
          # check first if user already has that course in their profile
          check_exists = HobbyUser.find_by(hobby_id: found_hobby.id, user_id: u1.id)
          if check_exists
            flash[:alert] = "Error: Hobby already exists in your profile."
            redirect_to "/add_hobby"
            return
          end
          HobbyUser.create(hobby_id: found_hobby.id, user_id: u1.id, created_at: Time.now, updated_at: Time.now)
        # otherwise, add course to course database and then update join table to assign that course to the current user
        else
          Hobby.create(name: hobby, created_at: Time.now, updated_at: Time.now)
          u1 = User.find_by(email: current_admin.email)
          new_hobby = Hobby.find_by(name: hobby)
          HobbyUser.create(hobby_id: new_hobby.id, user_id: u1.id, created_at: Time.now, updated_at: Time.now)
        end
        respond_to do |format|
          format.html { redirect_to "/add_hobby", notice: "Successfully added hobby to profile." }
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user)
            .permit(:first_name, :last_name, :email, :role, :year, :search, :points, :hour)
    end
end
