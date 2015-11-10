module Admin
  class ArticleManagersController < ApplicationController
    before_action :set_article_manager, only: [:show, :edit, :update, :destroy]

    # GET /article_managers
    # GET /article_managers.json
    def index
      @article_managers = ArticleManager.all
    end

    # GET /article_managers/1
    # GET /article_managers/1.json
    def show
    end

    # GET /article_managers/new
    def new
      @article_manager = ArticleManager.new
    end

    # GET /article_managers/1/edit
    def edit
    end

    # POST /article_managers
    # POST /article_managers.json
    def create
      community = Community.where(street: article_manager_params[:community]).first
      
      @article_manager = ArticleManager.new(article_manager_params)
      @article_manager.community = community
      respond_to do |format|
        if @article_manager.save
          format.html { redirect_to admin_article_managers_path }
          format.json { render :show, status: :created, location: @article_manager }
        else
          format.html { render :new }
          format.json { render json: @article_manager.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /article_managers/1
    # PATCH/PUT /article_managers/1.json
    def update
      respond_to do |format|
        if @article_manager.update(article_manager_params)
          format.html { redirect_to @article_manager, notice: 'Article manager was successfully updated.' }
          format.json { render :show, status: :ok, location: @article_manager }
        else
          format.html { render :edit }
          format.json { render json: @article_manager.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /article_managers/1
    # DELETE /article_managers/1.json
    def destroy
      @article_manager.destroy
      respond_to do |format|
        format.html { redirect_to admin_article_managers_url }
        format.json { head :no_content }
      end
    end

    private

      # Use callbacks to share common setup or constraints between actions.
      def set_article_manager
        @article_manager = ArticleManager.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def article_manager_params
        params.require(:article_manager).permit(:article_id, :keyword, :page_url, :article_index, :community)
      end
  end
end
