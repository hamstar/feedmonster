class Tag < ActiveRecord::Base
  has_and_belongs_to_many :feed_items
end
