class CronController < ApplicationController

  before_filter :check_if_there_are_sources

  def check_if_there_are_sources
    if Source.count < 1
      return false
    end
  end

  def index

  	@sources = Source.all
	
	@sources.each do |source|
		FeedEntry.update_from_feed( source.url )
	end

	if FeedEntry.count > 0
		last_entry_id = FeedEntry.last.object_id
	else
		last_entry_id = 0
	end

	@feed_entries = FeedEntry.find("id > ?", last_entry_id )

	@tags = Tag.all
	@feed_entries.each do |item|
		item.check_for_tags( @tags )
	end
  end

end
