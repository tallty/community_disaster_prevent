module Admin
  class UsersController < ApplicationController
    layout 'admin/home'

    def index
      @users = User.all
    end
  end
end
