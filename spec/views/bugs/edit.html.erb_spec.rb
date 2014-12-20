require 'rails_helper'

RSpec.describe "bugs/edit", :type => :view do
  before(:each) do
    @bug = assign(:bug, Bug.create!())
  end

  it "renders the edit bug form" do
    render

    assert_select "form[action=?][method=?]", bug_path(@bug), "post" do
    end
  end
end
