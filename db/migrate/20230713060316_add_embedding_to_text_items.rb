class AddEmbeddingToTextItems < ActiveRecord::Migration[7.0]
  def change
    add_column :text_items, :embedding, :vector, limit: 1536
  end
end
