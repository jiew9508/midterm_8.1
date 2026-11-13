class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :topic, null: false
      t.timestamps
    end
    add_index :articles, :topic
  end
end
