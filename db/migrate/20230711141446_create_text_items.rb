class CreateTextItems < ActiveRecord::Migration[7.0]
  def change
    create_table :text_items do |t|
      t.integer :text_number
      t.integer :paragraph
      t.references :section, null: false, foreign_key: true
      t.references :chapter, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
