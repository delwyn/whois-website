class Query
  attr_reader :query

  delegate :content, :server, :available?, to: :result
  delegate :host, to: :server

  def initialize(query)
    @query = query
  end

  def result
    @result ||= Whois::Client.new.query(@query)
  end
end
