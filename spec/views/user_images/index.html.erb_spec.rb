require 'spec_helper'

describe "user_images/index.html.erb" do
  before(:each) do
    assign(:user_images, [
      stub_model(UserImage,
        :name => "Name",
        :caption => "MyText"
      ),
      stub_model(UserImage,
        :name => "Name",
        :caption => "MyText"
      )
    ])
  end

  it "renders a list of user_images" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
