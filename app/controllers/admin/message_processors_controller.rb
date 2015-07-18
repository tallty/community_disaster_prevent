module Admin
  class MessageProcessorsController < ApplicationController
    before_action :set_message_processor, only: [:show, :edit, :update, :destroy]
    layout 'admin/home'
    
    # GET /message_processors
    # GET /message_processors.json
    def index
      @message_processors = MessageProcessor.all
    end

    # GET /message_processors/1
    # GET /message_processors/1.json
    def show
    end

    # GET /message_processors/new
    def new
      @message_processor = MessageProcessor.new
    end

    # GET /message_processors/1/edit
    def edit
    end

    # POST /message_processors
    # POST /message_processors.json
    def create
      @message_processor = MessageProcessor.new(message_processor_params)

      respond_to do |format|
        if @message_processor.save
          format.html { redirect_to @message_processor, notice: 'Message processor was successfully created.' }
          format.json { render :show, status: :created, location: @message_processor }
        else
          format.html { render :new }
          format.json { render json: @message_processor.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /message_processors/1
    # PATCH/PUT /message_processors/1.json
    def update
      respond_to do |format|
        if @message_processor.update(message_processor_params)
          format.html { redirect_to @message_processor, notice: 'Message processor was successfully updated.' }
          format.json { render :show, status: :ok, location: @message_processor }
        else
          format.html { render :edit }
          format.json { render json: @message_processor.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /message_processors/1
    # DELETE /message_processors/1.json
    def destroy
      @message_processor.destroy
      respond_to do |format|
        format.html { redirect_to message_processors_url, notice: 'Message processor was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_message_processor
        @message_processor = MessageProcessor.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def message_processor_params
        params[:message_processor]
      end
  end
end