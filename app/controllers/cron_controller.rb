class CronController < ApplicationController

  def index

  	@sources = Source.all

	@sources.each do |source|
		FeedEntry.get_feed( source.url )
	end
  end

end
