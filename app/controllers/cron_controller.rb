class CronController < ApplicationController

  before_filter :check_if_there_are_sources, :check_if_there_are_tags

  def index

  	@sources = Source.all
	
	start_time = Time.now

	@sources.each do |source|
		FeedEntry.update_from_feed( source.url )
	end

	@feed_entries = FeedEntry.all :conditions => ["DATE(created_at) > DATE(?)", start_time ]

	if @feed_entries.count == 0
		@message = "No entries were created"
		render :failed
	end

	tag_entries @feed_entries
  end

  def retag
    
    start_time = Time.now
    tag_entries FeedEntry.all
	
	@feed_entries = FeedEntry.all :conditions => ["DATE(updated_at) > DATE(?)", start_time ]

	if @feed_entries.count == 0
		flash[:notice] = "No entries were tagged"
	end
	
    render 'feed_entries/index'
  end

  private

  def tag_entries(entries)

	@tags = Tag.all
	entries.each do |entry|
		entry.check_for_tags( @tags )
	end
  end

  def check_if_there_are_sources
    if Source.count < 1
      @message = "No sources defined yet"
      render :failed
    end
  end

  def check_if_there_are_tags
  	if Tag.count < 1
  	  @message = "No tags defined yet"
  	  render :failed
  	end
  end

end
