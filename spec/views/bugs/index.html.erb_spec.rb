require 'rails_helper'

RSpec.describe "bugs/index", :type => :view do
  before(:each) do
    assign(:bugs, [
      Bug.create!(),
      Bug.create!()
    ])
  end

  it "renders a list of bugs" do
    render
  end
end
