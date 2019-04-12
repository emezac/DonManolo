require 'lib/Register.rb'

class PosModel

   def initialize
    @listeners = []
   end

   def add_listener(listener)
    @listeners << listener
   end

   def procItem(barcode,qty,client,tot, idv, disc, cashier, pricegr)
      @barcode, @qty, @client, @t , @idv, @di, @cs , @pricegr = barcode, qty, client, tot, idv, disc, cashier, pricegr
      unless @pricegr["qty"] == 0.0 or !@pricegr.empty? then
       @reg = Register.new
       @idt = @reg.enterItem(@barcode,@qty,@client,@idv, @di, @cs)
      end
      if @idt == -1 then
        @listeners.each {|l| l.notfound_changer }
      else
        @listeners.each {|l| l.item_changer(@barcode,@qty,@client,@t, @di, @pricegr, @idt) }
      end
   end

   def findItem(s)
      @s = s
      @reg = Register.new
      @id = @reg.searchItem(@s)
      @listeners.each {|l| l.search_changer(@id) }
   end

   def payItems(idt,payment,client,typ, dis)
      @idt,@payment,@client, @typ, @disc = idt,payment,client, typ, dis
      @sub = @reg.endSale(@idt,@payment,@typ, @client, @disc)
      @listeners.each {|l| l.client_changer(@idt,@sub,@client,@typ) }
   end

   def returnItem(idv,idp,qty,d)
       @idv, @idp, @qty, @d = idv, idp, qty, d
       @reg.enterReturnItem(@idv, @idp, @qty)
       @listeners.each {|l| l.item_eraser(@idv,@idp,@qty,@d) }
   end

   def returnSale(idv)
       @idv = idv
       @reg.enterReturnSale(@idv)
       @listeners.each {|l| l.sale_eraser }
   end
  
   def cancelall(idv)
       @idv = idv
       @reg.cancelSale(@idv)
       @listeners.each {|l| l.cancel_changer }
   end

   def print_ticket
       @reg.printt
   end
end

