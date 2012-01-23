class UserImage < ActiveRecord::Base
  belongs_to :user

  #paperclip config
  #in the strings below, # and > refer to image magic commands that influence 
  #how the image is resized.
  has_attached_file :image, :styles => {
    :thumb => "100x100#", :small => "400x400>" }
end
