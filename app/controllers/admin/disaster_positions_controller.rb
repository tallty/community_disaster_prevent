module Admin
  class DisasterPositionsController < ApplicationController
    before_action :set_disaster_position, only: [:show, :edit, :update, :destroy]

    # GET /disaster_positions
    # GET /disaster_positions.json
    def index
      @disaster_positions = DisasterPosition.all
    end

    # GET /disaster_positions/1
    # GET /disaster_positions/1.json
    def show
    end

    # GET /disaster_positions/new
    def new
      @disaster_position = DisasterPosition.new
    end

    # GET /disaster_positions/1/edit
    def edit
    end

    # POST /disaster_positions
    # POST /disaster_positions.json
    def create
      @disaster_position = DisasterPosition.new(disaster_position_params)

      respond_to do |format|
        if @disaster_position.save
          format.html { redirect_to @disaster_position, notice: 'Disaster position was successfully created.' }
          format.json { render :show, status: :created, location: @disaster_position }
        else
          format.html { render :new }
          format.json { render json: @disaster_position.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /disaster_positions/1
    # PATCH/PUT /disaster_positions/1.json
    def update
      respond_to do |format|
        if @disaster_position.update(disaster_position_params)
          format.html { redirect_to @disaster_position, notice: 'Disaster position was successfully updated.' }
          format.json { render :show, status: :ok, location: @disaster_position }
        else
          format.html { render :edit }
          format.json { render json: @disaster_position.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /disaster_positions/1
    # DELETE /disaster_positions/1.json
    def destroy
      @disaster_position.destroy
      respond_to do |format|
        format.html { redirect_to disaster_positions_url, notice: 'Disaster position was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_disaster_position
        @disaster_position = DisasterPosition.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def disaster_position_params
        params[:disaster_position]
      end
  end
end