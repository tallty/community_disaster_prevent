class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:edit, :create, :update]
  layout 'weixin'

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.where(openid: params[:openid]).first
  end

  # GET /subscribers/1/edit
  def edit
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to @subscriber, notice: 'Subscriber was successfully created.' }
        format.json { render :show, status: :created, location: @subscriber }
      else
        format.html { render :new }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscribers/1
  # PATCH/PUT /subscribers/1.json
  def update
    @community = Community.where(district: params[:subscriber][:community]).first
    @subscriber.community = @community
    respond_to do |format|
      if @subscriber.update_attributes(:community => @community)
        format.html { redirect_to "/subscribers/new?openid=#{@subscriber.openid}" }
        format.json { render :show, status: :ok, location: @subscriber }
      else
        format.html { render :edit }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_districts
    street = params[:street]
    @districts = Community.where(street: street).pluck(:district)
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.where(openid: params[:subscriber][:openid]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:openid, :community)
    end
end
