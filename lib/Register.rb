#!/usr/bin/ruby

require 'lib/ProductCatalog.rb'
require 'lib/ProcessSale.rb'
require 'lib/General.rb'

class Register

  # XXX
  # * access public 
  def endSale(idv, payment, typ, client, dis)
     @idv, @pay, @typ, @cli, @dis = idv , payment, typ, client, dis
     @es = ProcessSale.new
     @sub = @es.getSubtotal(@idv)
     @change = @pay.to_f - @sub.to_f
     @es.getBalance(@idv,@sub)
     makePayment(@typ,@sub,@idv, @cli, @dis)
     return @sub
  end

  public :endSale

  def searchItem(s)
     @s = s
     @prod = ProductCatalog.new 
     @f = @prod.searchItem(@s)
  end

  # XXX
  # * access public 
  # * param ItemID id 
  # * param Integer qty 
  
  def enterItem( idprod, qty, clientid, idtran, d, cas)
    @idprod, @qty, @clientid, @idtran, @di, @cas  = idprod, qty, clientid, idtran, d, cas
    @es = ProcessSale.new
    @prod = ProductCatalog.new 
    @price  = @prod.getProductPrice(@idprod)
    if @price > 0.0001 then
     @idtran = @es.addTran(@idtran,@idprod,@qty,@price,@clientid, @di, @cas) 
    else
     @idtran = -1
    end
    return @idtran
  end
  public :enterItem

  def updateItem(id,price,qty)
    @id, @price, @qty = id, price, qty
    @es = ProcessSale.new
    @es.updateItem(@id,@price,@qty)
  end
 
  def makeNewSale
     @key = Time.now.strftime("%Y%m%d%I%M%S").to_i
     @s   = ProcessSale.new  
     @s.create(@key)
  end
  public :makeNewSale

  # XXX
  # * access public 
  # * param Money cashTendered 
  
  def makePayment( cashTendered, amount, trans, clientid, disc )
    @cashTendered, @amount, @trans, @clientid, @disc = cashTendered, amount, trans, clientid, disc
    @es = ProcessSale.new
    case @cashTendered
       when @cashTendered = "Cash"
            @es.makeCashPayment(@trans,@amount, @clientid)
       when @cashTendered = "Credit" 
            @es.makeCreditPayment(@trans,@amount, @clientid)
       when @cashTendered = "CreditCard"   
            @es.makeCreditPayment(@trans,@amount, @clientid)
       when @cashTendered = "Promo"
            @es.makePromoPayment(@trans,@amount, @clientid, @disc) 
    end
  end
  public :makePayment

  # XXX
  # * access public 
  def makeNewReturn
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end
  public :makeNewReturn

  # XXX
  # * access public 
  def enterReturnItem(id,prod,qty)
    @id, @prod, @qty = id,prod,qty
    @es = ProcessSale.new
    @es.makeReturn(@id,@prod,@qty)
  end
  public :enterReturnItem
 
  def enterReturnSale(idv)
    @idv = idv
    @es = ProcessSale.new
    @es.makeReturnSale(@idv)
  end

  def getClientName(idc)
    @g = General.new
  end

  def cancelSale(idv)
    @idv = idv
    @es = ProcessSale.new
    @es.makeCancelSale(@idv)
  end


  def checkout
    @es = ProcessSale.new
    @es.checkOut
  end

  def updatei
    @es = ProcessSale.new
    @es.updatei
  end

  def isGranular(bc)
    @g = General.new
    @g.isGranular(bc)
  end

  def printt(idv,t,pr)
    @g = General.new
    @g.printt(idv,t,pr)
  end

end

