class Tag < ActiveRecord::Base
  before_create :create_slug
  has_and_belongs_to_many :feed_entries

  private

  def create_slug
    self.slug = self.name.parameterize
  end
end
