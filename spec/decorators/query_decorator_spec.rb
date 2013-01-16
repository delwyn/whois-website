require 'spec_helper'

describe QueryDecorator do
  let(:query) { Query.new('domain.com') }

  subject { QueryDecorator.decorate(query) }

  describe '#content' do
    it 'returns the content with line breaks replaced by br' do
      query.stub(:content) { "some\nresult" }
      subject.content.should eq 'some<br>result'
    end

    it 'rescues from Whois::WebInterfaceError' do
      query.stub(:content).and_raise(Whois::WebInterfaceError, 'no whois server')
      subject.content.should match /no whois server/
    end

    it "rescues from other errors" do
      query.stub(:content).and_raise(StandardError, 'error')
      subject.content.should match /something went wrong/i
    end
  end

  describe '#host' do
    it "returns the server host" do
      query.stub(:host) { 'test.com' }
      subject.host.should eq 'test.com'
    end

    it "rescues from other errors" do
      query.stub(:host).and_raise(StandardError, 'error')
      subject.host.should be_nil
    end
  end

  describe '#available?' do
    it 'returns Yes when true' do
      query.stub(:available?) { true }
      subject.available?.should eq 'Yes'
    end

    it 'returns No when false' do
      query.stub(:available?) { false }
      subject.available?.should eq 'No'
    end

    it 'rescues from errors' do
      query.stub(:available?).and_raise(StandardError, 'error')
      subject.available?.should be_nil
    end
  end
end
