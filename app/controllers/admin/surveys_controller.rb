module Admin
  class SurveysController < ApplicationController
    before_action :set_survey, only: [:show, :edit, :update, :destroy]
    layout 'admin/home'

    # GET /surveys
    # GET /surveys.json
    def index
      @surveys = Survey.all
    end

    # GET /surveys/1
    # GET /surveys/1.json
    def show
    end

    # GET /surveys/new
    def new
      @survey = Survey.new
    end

    # GET /surveys/1/edit
    def edit
    end

    # POST /surveys
    # POST /surveys.json
    def create
      @survey = Survey.new(survey_params)
      community = Community.where(id: params[:community]).first
      @survey.community = community
      questions = []
      if params[:survey][:questions].present?
        params[:survey][:questions].each do |title|
          question = Question.where(q_title: title).first
          questions << question if question.present?
        end
      end
      @survey.questions = questions
      respond_to do |format|
        if @survey.save
          format.html { redirect_to admin_survey_path(@survey), notice: 'Survey was successfully created.' }
          format.json { render :show, status: :created, location: @survey }
        else
          format.html { render :new }
          format.json { render json: @survey.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /surveys/1
    # PATCH/PUT /surveys/1.json
    def update
      respond_to do |format|
        if @survey.update(survey_params)
          format.html { redirect_to admin_survey_path(@survey), notice: 'Survey was successfully updated.' }
          format.json { render :show, status: :ok, location: @survey }
        else
          format.html { render :edit }
          format.json { render json: @survey.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /surveys/1
    # DELETE /surveys/1.json
    def destroy
      @survey.destroy
      respond_to do |format|
        format.html { redirect_to admin_surveys_path }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_survey
        @survey = Survey.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def survey_params
        params.require(:survey).permit(:s_title, :s_digest, :s_author)
      end
  end
end
