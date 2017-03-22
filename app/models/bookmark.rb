class Bookmark < ApplicationRecord
  acts_as_taggable
  searchkick highlight: [:title, :url, :notes]
  before_save :sanitize

  validates :url, presence: true, url: true

  belongs_to :user

  scope :search_import, -> { includes(:tags) }

  def search_data
    attributes.merge(
      tag: tags.map(&:name),
      user_id: user_id
    )
  end

  def self.search_fields
    @@search_fields ||= new.search_data.keys
  end

  def sanitize
    self.title = Sanitize.fragment(title)
    self.notes = Sanitize.fragment(notes)
  end
end
