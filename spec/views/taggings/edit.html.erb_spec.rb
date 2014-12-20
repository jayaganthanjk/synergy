require 'rails_helper'

RSpec.describe "taggings/edit", :type => :view do
  before(:each) do
    @tagging = assign(:tagging, Tagging.create!())
  end

  it "renders the edit tagging form" do
    render

    assert_select "form[action=?][method=?]", tagging_path(@tagging), "post" do
    end
  end
end
