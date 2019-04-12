#!/usr/bin/ruby

require 'lib/ProxyDb.rb'

class ProductCatalog

  # * access public 
  # * param ItemID id 

  def getProductSpec(itemID)
    @id = itemID
    p = Item.find(:first, :conditions => ["barcode = ?", @id])
    p.description
  end

  public :getProductSpec

  def getProductPrice(itemID)
    @id = itemID
    p = Item.find(:first, :conditions => ["barcode = ?", @id])
    if p then
      p.price
    else
      return -1
    end
  end
  public :getProductPrice

  # XXX
  # * access public 

  def loadProdSpecs
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end
  public :loadProdSpecs

  def searchItem(s)
    @s = s
    query ="select barcode,description,price,qty from items WHERE description like '%" + "#{@s}" + "%'"
    p = Item.find_by_sql "#{query}"
  rescue ActiveRecord::RecordNotFound, "No record found"
  end

  def isGranular(bc)
    n = Category.find(Item.find(:first, :conditions => ["barcode = ?",bc]).category_id).name
    return -1 unless n =~ /Granular/
  end

end

