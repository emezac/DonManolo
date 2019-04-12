class CreateAliases < ActiveRecord::Migration
  def self.up
    create_table :aliases do |t|
    end
  end

  def self.down
    drop_table :aliases
  end
end
