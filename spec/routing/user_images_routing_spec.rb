require "spec_helper"

describe UserImagesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/user_images" }.should route_to(:controller => "user_images", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/user_images/new" }.should route_to(:controller => "user_images", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/user_images/1" }.should route_to(:controller => "user_images", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/user_images/1/edit" }.should route_to(:controller => "user_images", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/user_images" }.should route_to(:controller => "user_images", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/user_images/1" }.should route_to(:controller => "user_images", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/user_images/1" }.should route_to(:controller => "user_images", :action => "destroy", :id => "1")
    end

  end
end
