
class Item < ActiveRecord::Base
  belongs_to :wmsystem
  belongs_to :category
  has_many :item_aliases

  validates_presence_of :barcode, :description, :price, :cost_price, :qty,  :expiration_date, :minimum_stock, :category_id

  validates_numericality_of :barcode, :price, :cost_price, :qty, :minimum_stock

  def validate

    errors.add(:price, "should be at least 0.01") if price.nil? ||  price < 0.01
    errors.add(:cost_price, "should be < price") if cost_price >= price

  end

  def self.search(query)
   if !query.to_s.strip.empty?
      tokens = query.split.collect {|c| "%#{c.downcase}%"}
      find_by_sql(["select s.* from items s where #{ (["(lower(s.description) like ? or lower(s.price) like ?)"] * tokens.size).join(" and ") } order by s.id desc", *(tokens * 2).sort])
   else
      []
   end
  end

  def self.categories
    query = "select distinct categories.id,categories.name from categories, items WHERE category_id = categories.id"
    Item.find_by_sql "#{query}"
 end
end
