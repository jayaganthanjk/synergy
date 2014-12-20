require 'rails_helper'

RSpec.describe "sprints/new", :type => :view do
  before(:each) do
    assign(:sprint, Sprint.new())
  end

  it "renders new sprint form" do
    render

    assert_select "form[action=?][method=?]", sprints_path, "post" do
    end
  end
end
