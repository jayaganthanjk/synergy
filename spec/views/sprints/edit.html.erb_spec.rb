require 'rails_helper'

RSpec.describe "sprints/edit", :type => :view do
  before(:each) do
    @sprint = assign(:sprint, Sprint.create!())
  end

  it "renders the edit sprint form" do
    render

    assert_select "form[action=?][method=?]", sprint_path(@sprint), "post" do
    end
  end
end
