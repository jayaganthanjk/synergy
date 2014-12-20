require 'rails_helper'

RSpec.describe "sprints/show", :type => :view do
  before(:each) do
    @sprint = assign(:sprint, Sprint.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
