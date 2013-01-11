class Query
  delegate :content, to: :result

  attr_reader :query

  def initialize(query)
    @query = query
  end

  def client
    @client ||= Whois::Client.new
  end

  def result
    @result ||= client.query(@query)
  end

  def to_html
    content.gsub("\n", "<br>")
  end
end
