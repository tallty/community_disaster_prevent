module Admin
  class DiymenusController < ApplicationController
    before_action :set_diymenu, only: [:show, :edit, :update, :destroy]

    # GET /diymenus
    # GET /diymenus.json
    def index
      @diymenus = Diymenu.all
    end

    # GET /diymenus/1
    # GET /diymenus/1.json
    def show
    end

    # GET /diymenus/new
    def new
      @diymenu = Diymenu.new
    end

    # GET /diymenus/1/edit
    def edit
    end

    # POST /diymenus
    # POST /diymenus.json
    def create
      @diymenu = Diymenu.new(diymenu_params)

      respond_to do |format|
        if @diymenu.save
          format.html { redirect_to @diymenu, notice: 'Diymenu was successfully created.' }
          format.json { render :show, status: :created, location: @diymenu }
        else
          format.html { render :new }
          format.json { render json: @diymenu.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /diymenus/1
    # PATCH/PUT /diymenus/1.json
    def update
      respond_to do |format|
        if @diymenu.update(diymenu_params)
          format.html { redirect_to @diymenu, notice: 'Diymenu was successfully updated.' }
          format.json { render :show, status: :ok, location: @diymenu }
        else
          format.html { render :edit }
          format.json { render json: @diymenu.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /diymenus/1
    # DELETE /diymenus/1.json
    def destroy
      @diymenu.destroy
      respond_to do |format|
        format.html { redirect_to diymenus_url, notice: 'Diymenu was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_diymenu
        @diymenu = Diymenu.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def diymenu_params
        params[:diymenu]
      end
  end
end
