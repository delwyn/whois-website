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
    begin
      content.gsub("\n", "<br>")
    rescue Whois::WebInterfaceError => e
      e.message
    rescue
      'Oops - Something went wrong'
    end
  end
end
