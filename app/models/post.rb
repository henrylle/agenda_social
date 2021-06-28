class Post < ApplicationRecord
  belongs_to :destination_post
  has_one_attached :url_photo
end
