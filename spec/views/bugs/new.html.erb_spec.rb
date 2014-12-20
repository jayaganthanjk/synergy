require 'rails_helper'

RSpec.describe "bugs/new", :type => :view do
  before(:each) do
    assign(:bug, Bug.new())
  end

  it "renders new bug form" do
    render

    assert_select "form[action=?][method=?]", bugs_path, "post" do
    end
  end
end
