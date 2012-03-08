class CronController < ApplicationController

  def index

  	@sources = Source.all

  end

end
