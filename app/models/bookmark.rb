class Bookmark < ApplicationRecord
  acts_as_taggable
  searchkick

  validates :url, presence: true, url: true

  belongs_to :user

  scope :search_import, -> { includes(:tags) }

  def search_data
    attributes.merge(
      tag: tags.map(&:name),
      user_id: user_id
    )
  end

  def to_s
    title.blank? ? url : title
  end

end
