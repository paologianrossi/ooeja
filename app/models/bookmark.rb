class Bookmark < ApplicationRecord
  acts_as_taggable

  validates :url, presence: true

  def to_s
    title.blank? ? url : title
  end
end
