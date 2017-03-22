class Search
  class Query
    QUERY_REGEXP = /tag\:\s*(?:\"([^"]*)\"|(\S+))/

    attr_reader :query, :page, :per_page

    def initialize(query="", page: nil, per_page: Kaminari.config.default_per_page, user: nil, klass: )
      @query = query || ""
      @page = page
      @per_page = per_page
      @user = user
      @klass= klass
    end

    def tag
      @tag ||= @query[QUERY_REGEXP, 1] || @query[QUERY_REGEXP, 2]
    end

    def text
      @text ||= @query.dup.tap do |text|
        text[QUERY_REGEXP] = "" if tag
        text.strip!
        text.replace(text.blank? ? "*" : text)
      end
    end

    def to_s
      tagged = "tagged '#{tag}'" if tag
      matching = "matching '#{text}'" unless text == '*'
      [tagged, matching].compact.join(" and ")
    end

    def empty?
      text == "*" && tag.nil?
    end

    def options
      {}.
        merge(where_clause).
        merge(page_clauses).
        merge(highlight_clauses)
    end

    def where_clause
      clause = { user_id: @user }
      clause.merge!({tag: tag }) if tag
      { where: clause }
    end

    def page_clauses
      {page: @page, per_page: @per_page}
    end

    def highlight_clauses
      {fields: @klass.search_fields, highlight: true}
    end
  end
end
