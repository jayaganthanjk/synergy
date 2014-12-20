require 'rails_helper'

RSpec.describe "stories/show", :type => :view do
  before(:each) do
    @story = assign(:story, Story.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
