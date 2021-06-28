class CreateDestinationPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :destination_posts do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
