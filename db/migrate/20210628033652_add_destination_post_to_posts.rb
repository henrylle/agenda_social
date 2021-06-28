class AddDestinationPostToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :destination_post, null: false, foreign_key: true
  end
end
