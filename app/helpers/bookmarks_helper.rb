module BookmarksHelper
  def highlighted(bookmark, field)
    if field == :title && bookmark.title.blank?
      field = :url
    end
    if bookmark.respond_to?(:search_highlights) && bookmark.search_highlights[field]
      bookmark.search_highlights[field].html_safe
    else
      bookmark[field].html_safe
    end
  end
end
