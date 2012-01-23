require 'spec_helper'

describe "user_images/new.html.erb" do
  before(:each) do
    assign(:user_image, stub_model(UserImage,
      :name => "MyString",
      :caption => "MyText"
    ).as_new_record)
  end

  it "renders new user_image form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => user_images_path, :method => "post" do
      assert_select "input#user_image_name", :name => "user_image[name]"
      assert_select "textarea#user_image_caption", :name => "user_image[caption]"
    end
  end
end
