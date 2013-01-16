require 'spec_helper'

describe Query do
  let(:query) { Query.new('domain.com') }
  let(:result) { double(content: "some\nresult") }

  it 'initializes with the string to query' do
    query.query.should eq 'domain.com'
  end

  describe '#result' do
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
end
