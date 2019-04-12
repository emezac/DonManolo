#!/usr/bin/ruby

#require 'libglade2'
require "observer"
require 'ProxyDb.rb'


class PosWatcher
  attr_writer :register

  def initialize(t,g,r)
    t.add_listener(self)
    @gui = g
    @reg = r
  end

  def item_changer(b,q,c,t,d, pgr, id)
     @b, @q, @c, @t, @d, @status, @id = b, q, c, t, d, pgr, id
     @prod = ProductCatalog.new
     @spec   = @prod.getProductSpec(@b)
     @price  = @prod.getProductPrice(@b)
     if @status.empty? then
       unless @prod.isGranular(@b) then
        @gui.granulargui(@price,@q)
       else
        @t = @t + (@q*@price - @q*@price*@d )
        @gui.fillitem(@q,@spec,@price,@b)
        @gui.set_total(@t)
        @gui.setItem
       end
     else
       @q = @status["qty"]
       @price = @status["price"]
       @t = @t + (@price - @price*@d )
       @gui.fillitem(@q,@spec,@price,@b)
       @reg.updateItem(@id,@price, @q)
       @gui.set_total(@t)
       @gui.setPricegr
       @gui.setItem
     end
  end

  def item_eraser(v,p,q,d)
     @v, @p, @q, @d = v, p, q, d
     @price  = @prod.getProductPrice(@p).to_f*@q.to_i
     @total = @gui.get_total - (@price - @price*d)
     @lq = @gui.getqitemlabel.to_i - @q.to_i
     @gui.removeitem
     if @lq == 0 then
        @gui.clearall
     else
        @gui.set_total(@total)
        @gui.setqitem(@lq.abs)
     end
  end

  def sale_eraser
     @gui.removesale
     @gui.setItem
  end

  def client_changer(idt,subt, cli , typ)
     @idt, @subt, @cli, @typ =  idt, subt, cli , typ 
     @gui.fillsale(@cli,@idt,@subt,@typ)
  end
  
  def search_changer(id)
     @id = id
     if @id == [] then
       @gui.fillsearch("","","","")
     else
       @id.each do |item|
         @gui.fillsearch(item["barcode"],item["description"],item["price"],item["qty"])
       end
     end
  end

  def cancel_changer
      @gui.clearall
  end

  def notfound_changer
     @gui.quickmessage("NO_RECORD_FOUND")
     @gui.setItem
  end

end
