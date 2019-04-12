class ItemPurchased < ActiveRecord::Base
  validates_presence_of :barcode, :price, :cost_price, :qty_purchased,  :date_purchased

  validates_numericality_of :price, :cost_price, :qty_purchased

  def validate
    errors.add(:price, "should be at least 0.01") if price.nil? ||  price < 0.01
    errors.add(:cost_price, "should be < price") if cost_price >= price
  end
end
