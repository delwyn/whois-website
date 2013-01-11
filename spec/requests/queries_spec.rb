require 'spec_helper'

describe "Queries" do
  describe "POST /queries" do
    before do
      result = double(content: 'some result')
      Whois::Client.any_instance.should_receive(:query).with('domain.com').and_return(result)
    end

    it "Runs the query and shows the results" do
      visit new_query_path
      fill_in 'query', with: 'domain.com'
      click_on 'Submit'
      page.should have_content 'some result'
    end
  end
end
