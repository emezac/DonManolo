class CreateCreditpayments < ActiveRecord::Migration
  def self.up
    create_table :creditpayments do |t|
    end
  end

  def self.down
    drop_table :creditpayments
  end
end
