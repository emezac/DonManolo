class CreateHistoricpurchases < ActiveRecord::Migration
  def self.up
    create_table :historicpurchases do |t|
    end
  end

  def self.down
    drop_table :historicpurchases
  end
end
