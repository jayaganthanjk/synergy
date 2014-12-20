require 'rails_helper'

RSpec.describe "timelogs/edit", :type => :view do
  before(:each) do
    @timelog = assign(:timelog, Timelog.create!())
  end

  it "renders the edit timelog form" do
    render

    assert_select "form[action=?][method=?]", timelog_path(@timelog), "post" do
    end
  end
end
