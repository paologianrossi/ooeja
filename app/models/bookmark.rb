class Bookmark < ApplicationRecord
  acts_as_taggable

  validates :url, presence: true

  belongs_to :user

  def to_s
    title.blank? ? url : title
  end
end
