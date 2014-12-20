require 'rails_helper'

RSpec.describe "timelogs/index", :type => :view do
  before(:each) do
    assign(:timelogs, [
      Timelog.create!(),
      Timelog.create!()
    ])
  end

  it "renders a list of timelogs" do
    render
  end
end
