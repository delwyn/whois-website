require 'spec_helper'

describe Query do
  let(:query) { Query.new('domain.com') }
  let(:result) { double(content: "some\nresult") }

  it 'initializes with the string to query' do
    query.query.should eq 'domain.com'
  end

  describe 'client' do
    it 'returns a new Whois::Client' do
      query.client.should be_an_instance_of Whois::Client
    end

    it 'stores the client in an instance variable' do
      query.client
      query.instance_variable_get(:@client).should be_an_instance_of Whois::Client
    end
  end

  describe 'result' do
    before do
      Whois::Client.any_instance.should_receive(:query).with('domain.com').and_return(result)
    end

    it 'returns the results from the whois query' do
      query.result.should eq result
    end

    it 'stores the result as an instance variable' do
      query.result
      query.instance_variable_get(:@result).should eq result
    end
  end

  describe 'to_html' do
    it 'returns the content with line breaks replaced by br' do
      query.stub(:result) { result }
      query.to_html.should eq 'some<br>result'
    end

    it 'rescues from Whois::WebInterfaceError' do
      query.stub(:content).and_raise(Whois::WebInterfaceError, 'no whois server')
      query.to_html.should match /no whois server/
    end

    it "rescues from other errors" do
      query.stub(:content).and_raise(StandardError, 'error')
      query.to_html.should match /something went wrong/i
    end
  end
end
