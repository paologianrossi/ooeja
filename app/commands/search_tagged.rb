class SearchTagged
  prepend SimpleCommand

  attr_reader :query

  def initialize(query, page: nil, per_page: Kaminari.config.default_per_page, user: nil, klass: Bookmark)
    @query = Query.new(query)
    @user = user
    @klass = klass
    @page = page
    @per_page
  end

  def call
    Results.new(@query, search)
  end

  def search
    return @klass.esearch(@query.text, where: { tag: @query.tag, user_id: @user }, page: @page, per_page: per_page) if @query.tag
    @klass.esearch(@query.text, where: { "user_id" => @user }, page: @page, per_page: 20)
  end

  def to_s
    class_name = @klass.name.humanize.downcase

    query.empty? ? "All #{class_name.pluralize(0)}" : "#{class_name.pluralize(0).capitalize} #{query}"
  end

  class Query
    QUERY_REGEXP = /tag\:\s*(?:\"([^"]*)\"|(\S+))/

    attr_reader :query

    def initialize(query)
      @query = query || ""
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
  end

  class Results
    attr_reader :query, :records

    def initialize(query, records)
      @query = query
      @records = records
    end

  end
end
