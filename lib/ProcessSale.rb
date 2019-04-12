#!/usr/bin/ruby

require "lib/item.class.rb" 
require "lib/General.rb" 
require 'lib/ProxyDb.rb'


class ProcessSale < Itemd

  # XXX 
  # * access public
  
  attr_accessor :quantity
  public :quantity

  # XXX
  # * access public 

  def getSubtotal(idv)
    @idv = idv
    @p = Saletransaction.sum(:total, :conditions => "idsale = #{@idv}")
  end
  public :getSubtotal

  def getBalance(idv, payment)
    @idv, @payment = idv, payment
    @sale = Sale.new
    @sale.idsale = @idv
    @sale.total = @payment
    @sale.save
  end
  
  def create(s)
     @s = s 
     @id = @s.to_s + rand(9).to_s
  end
  public :create

  def makeCashPayment(trans,amount, clientid)
    @trans, @amount, @clientid = trans, amount, clientid
    @cp = Cashpayment.new
    @cp.id = @trans
    @cp.amount = @amount
    @cp.clientid = @clientid
    @cp.save
  end
  public :makeCashPayment

  def makeCreditPayment(trans,amount, clientid)
    @trans, @amount, @clientid = trans, amount, clientid
    @cp = Creditpayment.new
    @cp.id = @trans
    @cp.amount = @amount
    @cp.clientid = @clientid
    @cp.save
  end
  public :makeCashPayment

  def makePromoPayment(trans,amount, clientid, disc)
    @trans, @amount, @clientid, @disc = trans, amount, clientid, disc
    @cp = Promopayment.new
    @cp.id = @trans
    @cp.amount = @amount
    @cp.clientid = @clientid
    @cp.discount = @disc
    @cp.save
  end
  public :makePromoPayment

  def addTran(id,idp,qty,price,clientid,d,cas)
    @id,@idp,@qty,@price,@clientid, @di, @cas = id,idp,qty,price, clientid, d, cas
    @t = Saletransaction.new
    @t.idsale = @id
    @t.qty = @qty
    @t.item = @idp
    @t.price = (@price - @price*@di)
    @t.clientid = @clientid
    @t.cashierid = @cas
    @t.total = @qty*@t.price
    @t.save
    idr = @t.id
    return idr
  end

  def updateItem(i,p,q)
    @i, @p, @q = i,p,q
    @st = Saletransaction.find(@i)
    @st.qty = @q
    @st.total = @p
    @st.update
  end

  def makeReturn(ids,idp,qty)
    @ids, @idp, @qty = ids,idp, qty
    @r = Itemreturn.new
    @s = Saletransaction.find(:first, :conditions => "idsale = #{@ids} AND item = #{@idp} AND qty = #{@qty}")
    @des = @s.id
    @r.idsale = @s.idsale
    @r.qty = @s.qty
    @r.item = @s.item
    @r.price = @s.price 
    @r.clientid = @s.clientid
    @r.total = @s.total
    @r.save
    @s = Saletransaction.destroy(@des)
  end
  public :makeReturn

  def makeReturnSale(idv)
    @idv = idv
    @sr  = Salereturn.new
    @s   = Sale.find(:first, :conditions => "idsale = #{@idv}")
    @des = @s.id
    @sr.idsale  = @s.idsale
    @sr.total   = @s.total
    @sr.save
    @s = Sale.destroy(@des)
  end
  public :makeReturnSale

  def makeCancelSale(idv)
    @idv = idv
    @t = Saletransaction.find(:all, :conditions => "idsale = #{@idv}")
    @t.each do | cp |
      Saletransaction.destroy(cp)
    end
  end

  def checkOut
    @st = Saletransaction.find(:all)
    @st.each do | usale|
        @s = Item.find(:first, :conditions => "barcode = #{usale.item}")
        @s.qty -= usale.qty
        @s.save
        @hs = Historicsale.new
        @hs.idsale  = usale.idsale
        @hs.item_id = usale.item
        @hs.qty     = usale.qty
        @hs.price   = usale.price
        @hs.client_id= usale.clientid
        @hs.cashier_id= usale.cashierid
        @hs.total   = usale.total
        @hs.save
        Saletransaction.destroy(usale)
    end
  end


  def updatei
    @pi = ItemPurchased.find(:all)
    @pi.each do | ip |
        @i = Item.find(:first, :conditions => "barcode = #{ip.barcode}")
        @i.qty += ip.qty_purchased
        @i.price = ip.price
        @i.cost_price = ip.cost_price
        @i.expiration_date = ip.expiration_date
        @i.update
        @hp = Historicpurchase.new
        @hp.barcode = ip.barcode
        @hp.price   = ip.price
        @hp.cost_price = ip.cost_price
        @hp.qty_purchased = ip.qty_purchased
        @hp.expiration_date = ip.expiration_date
        @hp.date_purchased  = ip.date_purchased
        @hp.save
        ItemPurchased.destroy(ip)
    end
  end

end
