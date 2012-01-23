class UserImagesController < ApplicationController
  # GET /user_images
  # GET /user_images.xml
  def index
    @user_images = UserImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_images }
    end
  end

  # GET /user_images/1
  # GET /user_images/1.xml
  def show
    @user_image = UserImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_image }
    end
  end

  # GET /user_images/new
  # GET /user_images/new.xml
  def new
    @user_image = UserImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_image }
    end
  end

  # GET /user_images/1/edit
  def edit
    @user_image = UserImage.find(params[:id])
  end

  # POST /user_images
  # POST /user_images.xml
  def create
    @user_image = UserImage.new(params[:user_image])

    respond_to do |format|
      if @user_image.save
        format.html { redirect_to(@user_image, :notice => 'User image was successfully created.') }
        format.xml  { render :xml => @user_image, :status => :created, :location => @user_image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_images/1
  # PUT /user_images/1.xml
  def update
    @user_image = UserImage.find(params[:id])

    respond_to do |format|
      if @user_image.update_attributes(params[:user_image])
        format.html { redirect_to(@user_image, :notice => 'User image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_images/1
  # DELETE /user_images/1.xml
  def destroy
    @user_image = UserImage.find(params[:id])
    @user_image.destroy

    respond_to do |format|
      format.html { redirect_to(user_images_url) }
      format.xml  { head :ok }
    end
  end
end
