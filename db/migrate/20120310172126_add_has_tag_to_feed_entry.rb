class AddHasTagToFeedEntry < ActiveRecord::Migration
  def change
  	add_column :feed_entries, :has_tag, :boolean
  end
end
