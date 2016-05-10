class AddArticles < ActiveRecord::Migration
  def change
    add_column :articles, :release, :boolean
  end
end
