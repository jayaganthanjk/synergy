require 'rails_helper'

RSpec.describe "searches/index", :type => :view do
  before(:each) do
    assign(:searches, [
      Search.create!(
        :index => "Index"
      ),
      Search.create!(
        :index => "Index"
      )
    ])
  end

  it "renders a list of searches" do
    render
    assert_select "tr>td", :text => "Index".to_s, :count => 2
  end
end
