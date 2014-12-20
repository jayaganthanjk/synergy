require 'rails_helper'

RSpec.describe "bugs/show", :type => :view do
  before(:each) do
    @bug = assign(:bug, Bug.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
