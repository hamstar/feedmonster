class FeedEntry < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def self.from_entry(entry)
    if exists? :guid => entry.id
      array = self.all :conditions => ["guid = ?", entry.id]
      return array.first
    end
    e = self.new :title         => entry.title,
                 :summary      => entry.summary,
                 :url          => entry.url,
                 :published_at => entry.published,
                 :guid         => entry.id
  end

  def check_for_tags(tags)
    found_a_tag = false
    tags.each do |tag|
      has_tag = false
      if title.downcase.include? tag.name.downcase
        has_tag = true
      end

      if summary.downcase.include? tag.name.downcase
        has_tag = true
      end

      if has_tag
        self.add_tag tag
        found_a_tag = true
      end
    end

    found_a_tag
  end

  def add_tag(tag)
    unless self.tags.include?(tag)
      self.tags << tag
    end
  end

  def get_tag_string
    if self.tags.count == 0
      return "None"
    end

    self.get_tag_names.join(', ')
  end

  def get_tag_names
    
    names = Array.new
    self.tags.each do |t|
      names << t.name
    end

    names
  end

  def self.get_feed(feed_url)
    Feedzirra::Feed.fetch_and_parse(feed_url)
  end

  def self.update_from_feed(feed_url)
    feed = self.get_feed( feed_url )
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
