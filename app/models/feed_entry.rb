class FeedEntry < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def check_for_tags(tags)
    tags.each do |tag|
      has_tag = false
      if title.include? tag.name
        has_tag = true
      end

      if summary.include? tag.name
        has_tag = true
      end

      if has_tag
        self.tags << tag
      end
    end
  end

  def self.get_feed(feed_url)
    Feedzirra::Feed.fetch_and_parse(feed_url)
  end

  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
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
