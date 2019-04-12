class CreateCashiers < ActiveRecord::Migration
  def self.up
    create_table :cashiers do |t|
    end
  end

  def self.down
    drop_table :cashiers
  end
end
