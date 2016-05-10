class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :anime_id
      t.string :image
      t.string :video_url
      t.string :frame
      t.boolean :release

      t.timestamps null: false
    end
  end
end
