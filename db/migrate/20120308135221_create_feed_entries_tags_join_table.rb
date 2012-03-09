class CreateFeedEntriesTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :feed_entries_tags, :id => false do |t|
      t.integer :feed_entry_id
      t.integer :tag_id
    end
    add_index :feed_entries_tags, [:feed_entry_id, :tag_id ]
  end
end
