# class CreateArticles < ActiveRecord::Migration[7.0]
class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
