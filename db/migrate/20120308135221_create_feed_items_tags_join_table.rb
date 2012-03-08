class CreateFeedItemsTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :feed_items_tags, :id => false do |t|
      t.integer :feed_item_id
      t.integer :tag_id
    end
  end
end
