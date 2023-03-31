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

    begin
      respond_to do |format|
        @consultation.save
        format.html { redirect_to consultation_url(@consultation), notice: "Consultation was successfully created." }
        format.json { render :show, status: :created, location: @consultation }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def consultation_params
      params.require(:consultation).permit(:title, :description, :start_time, :end_time, :code)
    end
end
