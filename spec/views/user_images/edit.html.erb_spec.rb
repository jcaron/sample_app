require 'spec_helper'

describe "user_images/edit.html.erb" do
  before(:each) do
    @user_image = assign(:user_image, stub_model(UserImage,
      :new_record? => false,
      :name => "MyString",
      :caption => "MyText"
    ))
  end

  it "renders the edit user_image form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => user_image_path(@user_image), :method => "post" do
      assert_select "input#user_image_name", :name => "user_image[name]"
      assert_select "textarea#user_image_caption", :name => "user_image[caption]"
    end
  end
end
