module Admin
  class PublishSurveysController < ApplicationController
    before_action :set_publish_survey, only: [:show, :edit, :update, :destroy]

    # GET /publish_surveys
    # GET /publish_surveys.json
    def index
      @publish_surveys = PublishSurvey.all
    end

    # GET /publish_surveys/1
    # GET /publish_surveys/1.json
    def show
    end

    # GET /publish_surveys/new
    def new
      @publish_survey = PublishSurvey.new
    end

    # GET /publish_surveys/1/edit
    def edit
    end

    # POST /publish_surveys
    # POST /publish_surveys.json
    def create
      @publish_survey = PublishSurvey.new()
      @publish_survey.survey_id = publish_survey_params[:survey_id]
      @publish_survey.community_id = Community.where(street: publish_survey_params[:community]).first.id

      respond_to do |format|
        if @publish_survey.save
          format.html { redirect_to admin_publish_surveys_path }
          format.json { render :show, status: :created, location: @publish_survey }
        else
          format.html { render :new }
          format.json { render json: @publish_survey.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /publish_surveys/1
    # PATCH/PUT /publish_surveys/1.json
    def update
      respond_to do |format|
        if @publish_survey.update(publish_survey_params)
          format.html { redirect_to @publish_survey, notice: 'Publish survey was successfully updated.' }
          format.json { render :show, status: :ok, location: @publish_survey }
        else
          format.html { render :edit }
          format.json { render json: @publish_survey.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /publish_surveys/1
    # DELETE /publish_surveys/1.json
    def destroy
      @publish_survey.destroy
      respond_to do |format|
        format.html { redirect_to publish_surveys_url, notice: 'Publish survey was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def switch
      publish_survey = PublishSurvey.where(id: params[:id]).first
      publish_survey.status = publish_survey.status.eql?("closed") ? 1 : 0
      publish_survey.save
      redirect_to admin_publish_surveys_path
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_publish_survey
        @publish_survey = PublishSurvey.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def publish_survey_params
        params.require(:publish_survey).permit(:survey_id, :community)
      end
  end
end
