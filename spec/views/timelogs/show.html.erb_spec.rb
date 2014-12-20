require 'rails_helper'

RSpec.describe "timelogs/show", :type => :view do
  before(:each) do
    @timelog = assign(:timelog, Timelog.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
