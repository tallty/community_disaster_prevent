class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:edit, :create, :update]
  layout 'weixin'

  # GET /subscribers/new
  def new
    openid = params[:openid] || session[:openid]
    @subscriber = Subscriber.where(openid: openid).first
    # 获取当前位置最近社区
    response = Community.fetchNearestCommunity params[:lon], params[:lat]

    result = MultiJson.load response.body

    p "========================"
    p result
    p "========================"
    if response.status == 200
      @community = result['Data']
    end
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
    @community = Community.where(street: params[:subscriber][:community]).first
    @subscriber.community = @community
    respond_to do |format|
      if @subscriber.update_attributes(:community => @community)
        format.html { redirect_to "/subscribers/new?openid=#{@subscriber.openid}", notice: "您当前绑定社区为: #{@community.street}." }
        format.json { render :show, status: :ok, location: @subscriber }
      else
        format.html { render :edit }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_streets
    district = params[:district]
    @streets = Community.where(district: district).pluck(:street)
    respond_to do |format|
      format.js
    end
  end

  def locate
    
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
