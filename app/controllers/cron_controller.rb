class CronController < ApplicationController

  before_filter :check_if_there_are_sources, :check_if_there_are_tags

  def index

  	@sources = Source.all
	
	  start_time = Time.now

    @saved = Array.new
    @tags = Tag.all
	  @sources.each do |source|
		  FeedEntry.get_feed( source.url ).entries.each do |entry|
        e = FeedEntry.from_entry entry
        if e.check_for_tags( @tags ) == true
          e.save
          @saved << e
        end
      end
	  end
  end

  def retag
    
    tag_entries FeedEntry.all
    flash[:notice] = "Retagged entries"
    redirect_to "/"
  end

  private

  def tag_entries(entries)

	  tags = Tag.all
	  entries.each do |entry|
		  entry.check_for_tags( tags )
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
