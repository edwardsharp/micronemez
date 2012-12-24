require 'spec_helper'

describe "schedules/new" do
  before(:each) do
    assign(:schedule, stub_model(Schedule,
      :name => "MyString",
      :description => "MyText",
      :live => false,
      :channel => "MyString",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => schedules_path, :method => "post" do
      assert_select "input#schedule_name", :name => "schedule[name]"
      assert_select "textarea#schedule_description", :name => "schedule[description]"
      assert_select "input#schedule_live", :name => "schedule[live]"
      assert_select "input#schedule_channel", :name => "schedule[channel]"
      assert_select "input#schedule_status", :name => "schedule[status]"
    end
  end
end
