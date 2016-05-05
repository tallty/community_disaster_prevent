# 微信端： 社区
class CommunitiesController < ApplicationController
	layout 'weixin'
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  respond_to :json, :html

	# 社区四个部分
	def interact
		@subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
	end

  def detection
    @subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
  end

  def community_risk
    @subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
  end

  def change_community
    @subscriber = Subscriber.where(openid: params[:openid]).first
    @disasters = Disaster.where("occur_time > ?", Time.now.to_date - 3.day).find_all { |d| d.subscriber == @subscriber or d.disaster_position.present? }
  end

  def centre
    # @community = Community.new(community_params)
    #   @community.code = Community.where(district: "杨浦").last.code.succ

    #   respond_to do |format|
    #     if @community.save
    #       format.html { redirect_to admin_communities_path }
    #       format.json { render :show, status: :created, location: @community }
    #     else
    #       format.html { render :new }
    #       format.json { render json: @community.errors, status: :unprocessable_entity }
    #     end
    #   end
  end

  # private
  #     # Use callbacks to share common setup or constraints between actions.
  #     def set_community
  #       @community = Community.find(params[:id])
  #     end

  #     # Never trust parameters from the scary internet, only allow the white list through.
  #     def community_params
  #       params.require(:community).permit(:district, :street, :c_type)
  #     end
end