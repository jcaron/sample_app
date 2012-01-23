require 'spec_helper'

describe "user_images/show.html.erb" do
  before(:each) do
    @user_image = assign(:user_image, stub_model(UserImage,
      :name => "Name",
      :caption => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
