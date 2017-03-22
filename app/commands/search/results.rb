class Search
  class Results
    attr_reader :query, :records

    def initialize(query, records)
      @query = query
      @records = records
    end
  end
end
