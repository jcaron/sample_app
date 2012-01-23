require 'spec_helper'

describe UserImagesController do

  def mock_user_image(stubs={})
    (@mock_user_image ||= mock_model(UserImage).as_null_object).tap do |user_image|
      user_image.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all user_images as @user_images" do
      UserImage.stub(:all) { [mock_user_image] }
      get :index
      assigns(:user_images).should eq([mock_user_image])
    end
  end

  describe "GET show" do
    it "assigns the requested user_image as @user_image" do
      UserImage.stub(:find).with("37") { mock_user_image }
      get :show, :id => "37"
      assigns(:user_image).should be(mock_user_image)
    end
  end

  describe "GET new" do
    it "assigns a new user_image as @user_image" do
      UserImage.stub(:new) { mock_user_image }
      get :new
      assigns(:user_image).should be(mock_user_image)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_image as @user_image" do
      UserImage.stub(:find).with("37") { mock_user_image }
      get :edit, :id => "37"
      assigns(:user_image).should be(mock_user_image)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created user_image as @user_image" do
        UserImage.stub(:new).with({'these' => 'params'}) { mock_user_image(:save => true) }
        post :create, :user_image => {'these' => 'params'}
        assigns(:user_image).should be(mock_user_image)
      end

      it "redirects to the created user_image" do
        UserImage.stub(:new) { mock_user_image(:save => true) }
        post :create, :user_image => {}
        response.should redirect_to(user_image_url(mock_user_image))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user_image as @user_image" do
        UserImage.stub(:new).with({'these' => 'params'}) { mock_user_image(:save => false) }
        post :create, :user_image => {'these' => 'params'}
        assigns(:user_image).should be(mock_user_image)
      end

      it "re-renders the 'new' template" do
        UserImage.stub(:new) { mock_user_image(:save => false) }
        post :create, :user_image => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested user_image" do
        UserImage.should_receive(:find).with("37") { mock_user_image }
        mock_user_image.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user_image => {'these' => 'params'}
      end

      it "assigns the requested user_image as @user_image" do
        UserImage.stub(:find) { mock_user_image(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:user_image).should be(mock_user_image)
      end

      it "redirects to the user_image" do
        UserImage.stub(:find) { mock_user_image(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(user_image_url(mock_user_image))
      end
    end

    describe "with invalid params" do
      it "assigns the user_image as @user_image" do
        UserImage.stub(:find) { mock_user_image(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:user_image).should be(mock_user_image)
      end

      it "re-renders the 'edit' template" do
        UserImage.stub(:find) { mock_user_image(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested user_image" do
      UserImage.should_receive(:find).with("37") { mock_user_image }
      mock_user_image.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the user_images list" do
      UserImage.stub(:find) { mock_user_image }
      delete :destroy, :id => "1"
      response.should redirect_to(user_images_url)
    end
  end

end
