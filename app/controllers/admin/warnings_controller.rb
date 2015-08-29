module Admin
  class WarningsController < ApplicationController

    def index
      keys = $redis.keys("warnings_*")
      @warnings = []
      keys.each do |item|
        @warnings << $redis.hvals(item).map { |e| MultiJson.load(e) }
      end
    end

    def show
      
    end


  end
end
