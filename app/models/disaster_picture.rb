# == Schema Information
#
# Table name: disaster_pictures
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  disaster_id        :integer
#

class DisasterPicture < ActiveRecord::Base
  belongs_to :disaster
  # has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :image, 
    :styles => { :medium => "300x300", :thumb => "100x100"},
    :path => ':rails_root/public/system/:id/:attachment/:style/:basename.:extension',
    :url => '/system/:id/:attachment/:style/:basename.:extension'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def as_json(options=nil)
    {
      id: id
    }
  end
end
