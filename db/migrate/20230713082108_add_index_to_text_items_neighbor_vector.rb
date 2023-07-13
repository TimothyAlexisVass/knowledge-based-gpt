class AddIndexToTextItemsNeighborVector < ActiveRecord::Migration[7.0]
  def change
    add_index :items, :embedding, using: :ivfflat, opclass: :vector_l2_ops
    TextItem.connection.execute("SET ivfflat.probes = 3")
  end
end

