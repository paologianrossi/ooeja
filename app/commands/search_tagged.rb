class SearchTagged
  prepend SimpleCommand

  def initialize(query, user=nil, klass=Bookmark)
    @query = Query.new(query)
    @user = user
    @klass = klass
  end

  def call
    Results.new(@query, search)
  end

  def search
    return @klass.esearch(@query.text, where: { tag: @query.tag, user_id: @user }) if @query.tag
    @klass.esearch(@query.text, where: { "user_id" => @user })
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
  end

  class Results
    attr_reader :query, :records

    def initialize(query, records)
      @query = query
      @records = records
      freeze
    end
  end
end
