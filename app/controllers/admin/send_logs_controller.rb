module Admin
  class SendLogsController < ApplicationController
    before_action :set_send_log, only: [:show, :edit, :update, :destroy]

    # GET /send_logs
    # GET /send_logs.json
    def index
      @send_logs = SendLog.all
    end

    # GET /send_logs/1
    # GET /send_logs/1.json
    def show
    end

    # GET /send_logs/new
    def new
      @send_log = SendLog.new
    end

    # GET /send_logs/1/edit
    def edit
    end

    # POST /send_logs
    # POST /send_logs.json
    def create
      @send_log = SendLog.new(send_log_params)

      respond_to do |format|
        if @send_log.save
          format.html { redirect_to @send_log, notice: 'Send log was successfully created.' }
          format.json { render :show, status: :created, location: @send_log }
        else
          format.html { render :new }
          format.json { render json: @send_log.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /send_logs/1
    # PATCH/PUT /send_logs/1.json
    def update
      respond_to do |format|
        if @send_log.update(send_log_params)
          format.html { redirect_to @send_log, notice: 'Send log was successfully updated.' }
          format.json { render :show, status: :ok, location: @send_log }
        else
          format.html { render :edit }
          format.json { render json: @send_log.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /send_logs/1
    # DELETE /send_logs/1.json
    def destroy
      @send_log.destroy
      respond_to do |format|
        format.html { redirect_to send_logs_url, notice: 'Send log was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_send_log
        @send_log = SendLog.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def send_log_params
        params[:send_log]
      end
  end
end
