class Search
  prepend SimpleCommand

  attr_reader :query

  def initialize(query, klass)
    @query = query
    @klass = klass
  end

  def call
    Results.new(@query, search)
  end

  def search
    return @klass.esearch(@query.text, @query.options)
  end

  def to_s
    class_name = @klass.name.humanize.downcase
    query.empty? ? "All #{class_name.pluralize(0)}" : "#{class_name.pluralize(0).capitalize} #{query}"
  end

end
