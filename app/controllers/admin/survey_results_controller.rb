module Admin
  class SurveyResultsController < ApplicationController
    before_action :set_survey_result, only: [:edit, :update, :destroy]

    # GET /survey_results
    # GET /survey_results.json
    def index
      @survey_results = SurveyResult.all
    end

    # GET /survey_results/1
    # GET /survey_results/1.json
    def show
      @survey = Survey.where(id: params[:id]).first
      question_ids = SurveyResult.where(survey: @survey).distinct(:q_index).pluck(:q_index)

      @questions = Question.where(id: question_ids)
    end

    # GET /survey_results/new
    def new
      @survey_result = SurveyResult.new
    end

    # GET /survey_results/1/edit
    def edit
    end

    # POST /survey_results
    # POST /survey_results.json
    def create
      subscriber = Subscriber.where(openid: params)
      @survey_result = SurveyResult.new(survey_result_params)

      respond_to do |format|
        if @survey_result.save
          format.html { redirect_to @survey_result, notice: 'Survey result was successfully created.' }
          format.json { render :show, status: :created, location: @survey_result }
        else
          format.html { render :new }
          format.json { render json: @survey_result.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /survey_results/1
    # PATCH/PUT /survey_results/1.json
    def update
      respond_to do |format|
        if @survey_result.update(survey_result_params)
          format.html { redirect_to @survey_result, notice: 'Survey result was successfully updated.' }
          format.json { render :show, status: :ok, location: @survey_result }
        else
          format.html { render :edit }
          format.json { render json: @survey_result.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /survey_results/1
    # DELETE /survey_results/1.json
    def destroy
      @survey_result.destroy
      respond_to do |format|
        format.html { redirect_to survey_results_url, notice: 'Survey result was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_survey_result
        @survey_result = SurveyResult.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def survey_result_params
        params[:survey_result]
      end
  end
end
