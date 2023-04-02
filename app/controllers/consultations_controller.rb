class ConsultationsController < ApplicationController
  before_action :set_consultation, only: %i[ show edit update destroy ]

  # GET /consultations or /consultations.json
  def index
    @consultations = Consultation.all
  end

  # GET /consultations/1 or /consultations/1.json
  def show
    if current_admin.admin?
      render "consultations/show"
    elsif current_admin.mentor?
      render "consultations/member_show"
    elsif current_admin.mentee?
      render "consultations/member_show"
    else
      render "dashboards/guest/guest"
    end
  end

  # GET /consultations/new
  def new
    @consultation = Consultation.new
  end

  # GET /consultations/1/edit
  def edit
  end

  # POST /consultations or /consultations.json
  def create
    @consultation = Consultation.new(consultation_params)


    respond_to do |format|
      if @consultation.save
        format.html { redirect_to pages_path(anchor: "consultation-notice"), notice: "Consultation was successfully created." }
        # format.json { render :show, status: :created, location: @consultation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @consultation.errors, status: :unprocessable_entity }

      end
    rescue ActiveRecord::RecordNotUnique => e
      flash[:notice] = "Sorry, an event with that attendance code already exists."
      redirect_to consultations_url
    end
  end

  # PATCH/PUT /consultations/1 or /consultations/1.json
  def update
    begin
      respond_to do |format|
        @consultation.update(consultation_params)
        format.html { redirect_to consultation_url(@consultation), notice: "Consultation was successfully updated." }
        format.json { render :show, status: :created, location: @consultation }
      end
    rescue ActiveRecord::RecordNotUnique => e
      flash[:notice] = "Sorry, an event with that attendance code already exists."
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consultations/1 or /consultations/1.json
  def destroy
    @consultation.destroy

    respond_to do |format|
      format.html { redirect_to consultations_url, notice: "Consultation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_code
    set_consultation
    if params[:code_input] == @consultation.code
      u1 = User.find_by(email:current_admin.email)
      attendance = UserEvent.new(user: u1, consultation: @consultation)
      if attendance.save
        u1.increment!(:points, @consultation.event_points)
        u1.save
        respond_to do |format|
          format.html { redirect_to consultation_url(@consultation), notice: "Successfully checked in." }
          format.json { render :show, status: :created, location: @consultation }
        end
      else
        respond_to do |format|
          format.html { redirect_to consultation_url(@consultation), notice: "You have already checked in to this event." }
          format.json { render json: attendance.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to consultation_url(@consultation), notice: "Incorrect code." }
        format.json { render :show, status: :created, location: @consultation }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def consultation_params
      params.require(:consultation).permit(:title, :description, :start_time, :end_time, :event_points, :code)
    end
end
