module Admin
  class DisasterPicturesController < ApplicationController
    before_action :set_disaster_picture, only: [:show, :edit, :update, :destroy]

    # GET /disaster_pictures
    # GET /disaster_pictures.json
    def index
      @disaster_pictures = DisasterPicture.all
    end

    # GET /disaster_pictures/1
    # GET /disaster_pictures/1.json
    def show
    end

    # GET /disaster_pictures/new
    def new
      @disaster_picture = DisasterPicture.new
    end

    # GET /disaster_pictures/1/edit
    def edit
    end

    # POST /disaster_pictures
    # POST /disaster_pictures.json
    def create
      @disaster_picture = DisasterPicture.new(disaster_picture_params)

      respond_to do |format|
        if @disaster_picture.save
          format.html { redirect_to @disaster_picture, notice: 'Disaster picture was successfully created.' }
          format.json { render :show, status: :created, location: @disaster_picture }
        else
          format.html { render :new }
          format.json { render json: @disaster_picture.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /disaster_pictures/1
    # PATCH/PUT /disaster_pictures/1.json
    def update
      respond_to do |format|
        if @disaster_picture.update(disaster_picture_params)
          format.html { redirect_to @disaster_picture, notice: 'Disaster picture was successfully updated.' }
          format.json { render :show, status: :ok, location: @disaster_picture }
        else
          format.html { render :edit }
          format.json { render json: @disaster_picture.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /disaster_pictures/1
    # DELETE /disaster_pictures/1.json
    def destroy
      @disaster_picture.destroy
      respond_to do |format|
        format.html { redirect_to disaster_pictures_url, notice: 'Disaster picture was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_disaster_picture
        @disaster_picture = DisasterPicture.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def disaster_picture_params
        params[:disaster_picture]
      end
  end
end