module Admin
  class CommunitiesController < ApplicationController
    before_action :set_community, only: [:show, :edit, :update, :destroy]
    layout 'admin/home'
    respond_to :json, :html

    def search
      @q = Community.ransack(params[:q])
      @community = @q.result(distinct: true).pluck(:street)
      respond_to do |format|
        format.json { render json: @community }
        format.js
      end
    end

    # GET /communities
    # GET /communities.json
    def index
      @communities = Community.all
    end

    # GET /communities/1
    # GET /communities/1.json
    def show
    end

    # GET /communities/new
    def new
      @community = Community.new
    end

    # GET /communities/1/edit
    def edit
    end

    # POST /communities
    # POST /communities.json
    def create
      @community = Community.new(community_params)
      @community.code = Community.where(district: "杨浦").last.code.succ

      respond_to do |format|
        if @community.save
          format.html { redirect_to admin_communities_path }
          format.json { render :show, status: :created, location: @community }
        else
          format.html { render :new }
          format.json { render json: @community.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /communities/1
    # PATCH/PUT /communities/1.json
    def update
      respond_to do |format|
        if @community.update(community_params)
          format.html { redirect_to @community, notice: 'Community was successfully updated.' }
          format.json { render :show, status: :ok, location: @community }
        else
          format.html { render :edit }
          format.json { render json: @community.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /communities/1
    # DELETE /communities/1.json
    def destroy
      @community.destroy
      respond_to do |format|
        format.html { redirect_to admin_communities_path }
        format.json { head :no_content }
      end
    end

    def get_streets
      @streets = Community.select(:street).distinct.pluck(:street)
      respond_to do |format|
        format.js
      end
    end

    def get_districts
      street = params[:street]
      @districts = Community.where(street: street).pluck(:district, :id)
      respond_to do |format|
        format.js
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_community
        @community = Community.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def community_params
        params.require(:community).permit(:district, :street, :c_type)
      end
  end
end
