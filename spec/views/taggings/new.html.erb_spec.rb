require 'rails_helper'

RSpec.describe "taggings/new", :type => :view do
  before(:each) do
    assign(:tagging, Tagging.new())
  end

  it "renders new tagging form" do
    render

    assert_select "form[action=?][method=?]", taggings_path, "post" do
    end
  end
end
