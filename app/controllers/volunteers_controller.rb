class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:edit]
  layout 'weixin'

  # GET /volunteers/new
  def new
    @subscriber = Subscriber.where(openid: params[:openid]).first
    if @subscriber.volunteer.present?
      @volunteer = @subscriber.volunteer
    else
      @volunteer = Volunteer.new
    end
    p @volunteer
  end

  # GET /volunteers/1/edit
  def edit
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @subscriber = Subscriber.where(openid: volunteer_params[:openid]).first
    if @subscriber.present?
      @volunteer = Volunteer.find_or_create_by(subscriber: @subscriber)
      @volunteer.name = volunteer_params[:name]
      @volunteer.tel = volunteer_params[:tel]
      @volunteer.commun = volunteer_params[:commun]
      @volunteer.neighborhood = volunteer_params[:neighborhood]
      respond_to do |format|
        if @volunteer.save
          format.html { render "volunteers/success" }
          format.json { render :show, status: :created, location: @volunteer }
        else
          format.html { render :new }
          format.json { render json: @volunteer.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /volunteers/1
  # PATCH/PUT /volunteers/1.json
  def update
    respond_to do |format|
      if @volunteer.update(volunteer_params)
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { render :show, status: :ok, location: @volunteer }
      else
        format.html { render :edit }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      params.require(:volunteer).permit(:openid, :name, :tel, :commun, :neighborhood)
    end
end
