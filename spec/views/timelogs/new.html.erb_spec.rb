require 'rails_helper'

RSpec.describe "timelogs/new", :type => :view do
  before(:each) do
    assign(:timelog, Timelog.new())
  end

  it "renders new timelog form" do
    render

    assert_select "form[action=?][method=?]", timelogs_path, "post" do
    end
  end
end
