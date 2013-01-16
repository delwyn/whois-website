class QueryDecorator < Draper::Decorator
  delegate_all

  def content
    model.content.gsub("\n", "<br>")
  rescue Whois::WebInterfaceError => e
    e.message
  rescue
    'Oops - Something went wrong'
  end

  def host
    model.host
  rescue
  end

  def available?
    model.available? ? 'Yes' : 'No'
  rescue
  end
end
