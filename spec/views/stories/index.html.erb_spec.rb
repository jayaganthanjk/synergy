require 'rails_helper'

RSpec.describe "stories/index", :type => :view do
  before(:each) do
    assign(:stories, [
      Story.create!(),
      Story.create!()
    ])
  end

  it "renders a list of stories" do
    render
  end
end
