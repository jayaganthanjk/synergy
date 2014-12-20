require 'rails_helper'

RSpec.describe "taggings/index", :type => :view do
  before(:each) do
    assign(:taggings, [
      Tagging.create!(),
      Tagging.create!()
    ])
  end

  it "renders a list of taggings" do
    render
  end
end
