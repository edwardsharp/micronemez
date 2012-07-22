require 'spec_helper'

describe "videos/edit" do
  before(:each) do
    @video = assign(:video, stub_model(Video,
      :catnum => "MyString",
      :title => "MyString",
      :location => "MyString",
      :tag => "MyString",
      :keyword => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => videos_path(@video), :method => "post" do
      assert_select "input#video_catnum", :name => "video[catnum]"
      assert_select "input#video_title", :name => "video[title]"
      assert_select "input#video_location", :name => "video[location]"
      assert_select "input#video_tag", :name => "video[tag]"
      assert_select "input#video_keyword", :name => "video[keyword]"
      assert_select "input#video_description", :name => "video[description]"
    end
  end
end
