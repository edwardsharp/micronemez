require 'spec_helper'

describe "videos/index" do
  before(:each) do
    assign(:videos, [
      stub_model(Video,
        :catnum => "catnum",
        :title => "Title",
        :location => "Location",
        :tag => "tag",
        :keyword => "Keyword",
        :description => "Description"
      ),
      stub_model(Video,
        :catnum => "catnum",
        :title => "Title",
        :location => "Location",
        :tag => "tag",
        :keyword => "Keyword",
        :description => "Description"
      )
    ])
  end

  it "renders a list of videos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "catnum".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "tag".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Keyword".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
