class FeedEntry < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def self.get_feed(feed_url)
    Feedzirra::Feed.fetch_and_parse(feed_url)
  end
  
  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id
        )
      end
    end
  end
end
