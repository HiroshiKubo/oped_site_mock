class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :anime_id
      t.string :title
      t.integer :video_id
      t.string :content
      t.string :oped
      t.integer :number
      t.string :advertisement
      t.string :initials

      t.timestamps null: false
    end
  end
end
