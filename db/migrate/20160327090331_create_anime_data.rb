class CreateAnimeData < ActiveRecord::Migration
  def change
    create_table :anime_data do |t|
      t.string :japanese
      t.string :english
      t.string :chinese
      t.string :year
      t.integer :month
      t.string :url

      t.timestamps null: false
    end
  end
end
