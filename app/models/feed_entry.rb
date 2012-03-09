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
        self.add_tag tag
      end
    end
  end

  def add_tag(tag)
    unless self.tags.include?(tag)
      self.tags << tag
    end
  end

  def get_tags_string
    if self.tags.count == 0
      return "None"
    end

    self.tags.each do |tag|
      string+= tag.name
    end

    return string
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
          :title         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id
        )
      end
    end
  end
end
