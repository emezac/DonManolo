class CreateItemPurchaseds < ActiveRecord::Migration
  def self.up
    create_table :item_purchaseds do |t|
    end
  end

  def self.down
    drop_table :item_purchaseds
  end
end
