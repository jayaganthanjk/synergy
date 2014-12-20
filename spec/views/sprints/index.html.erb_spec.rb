require 'rails_helper'

RSpec.describe "sprints/index", :type => :view do
  before(:each) do
    assign(:sprints, [
      Sprint.create!(),
      Sprint.create!()
    ])
  end

  it "renders a list of sprints" do
    render
  end
end
