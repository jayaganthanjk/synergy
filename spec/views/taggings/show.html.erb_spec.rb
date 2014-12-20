require 'rails_helper'

RSpec.describe "taggings/show", :type => :view do
  before(:each) do
    @tagging = assign(:tagging, Tagging.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
