#!/usr/bin/ruby

require 'lib/General.rb'
#require 'libglade2'
require 'gtk2'
require 'pango'

BUSINESS = "   La Michoacana\nTienda de abarrotes"
FLAGLEVEL = "12"
CLIENTNAME = "Client's Name"
CLIENTADDRESS = "Client's Address"
CLIENTTAXIDRFC = "Client's TaxidRFC"
CLIENTPOINTS = "Client's Points"
CASHIER = "Cashier"
OTHERDISCOUNT = 0.20
#PRINTER = "Host_or_Printer"
PRINTER = "rawp"

class PosGUI

  def initialize(register,item, cashier)
    @myreg,@item, @cs = register,item, cashier
    @glade = Gtk::UIManager.new
    @glade.add_ui("pos.ui")
    #@glade = GladeXML.new("pos.glade") {|handler| method(handler)}
    @window = @glade.get_widget("window1")
    @chang = @glade.get_widget("label6")
    @clockl = @glade.get_widget("label20")
    @flagl = @glade.get_widget("label10")
    @mybus = @glade.get_widget("label29")
    @vid = @glade.get_widget("label13")
    @lcashier = @glade.get_widget("label14")
    @lcashier.set_text(CASHIER)
    @cashier = @glade.get_widget("label15")
    @cname = @glade.get_widget("label16")
    @cname.set_text(CLIENTNAME)
    @cadd = @glade.get_widget("label27")
    @cadd.set_text(CLIENTADDRESS)
    @crfc = @glade.get_widget("label25")
    @crfc.set_text(CLIENTTAXIDRFC)
    @cpoints = @glade.get_widget("label18")
    @cpoints.set_text(CLIENTPOINTS)
    @clientname = @glade.get_widget("label17")
    @clientaddress = @glade.get_widget("label28")
    @clientrfc = @glade.get_widget("label26")
    @clientpoints = @glade.get_widget("label19")
    @trash_sale = @glade.get_widget("image4")
    @trash_osale = @glade.get_widget("image5")
    @mybus.set_text(BUSINESS)
    @flagl.set_text(FLAGLEVEL)
    @total = @glade.get_widget("label2")
    @pq = @glade.get_widget("label12")
    @pq.set_text("1")
    @qpt = 1
    @date = @glade.get_widget("label21")
    @date.text = Time.now.strftime("%d/%m/%Y")
    @entrybarcode = @glade.get_widget("entry1")
    @entrysearch = @glade.get_widget("entry2")
    @entryclient = @glade.get_widget("entry3")
    @entrypayment = @glade.get_widget("entry4")
    @entryqty = @glade.get_widget("entry6")
    @entryprgr = @glade.get_widget("entry7")
    @entryopprgr = @glade.get_widget("entry8")
    @newclientb = @glade.get_widget("button1") 
    @tpaymentcash = @glade.get_widget("radiobutton1") 
    @tpaymentcredit = @glade.get_widget("radiobutton2") 
    @tpaymentdisc = @glade.get_widget("radiobutton3") 
    @tpaymenttcred = @glade.get_widget("radiobutton4") 
    @dal5 = @glade.get_widget("checkbutton1") 
    @dal10= @glade.get_widget("checkbutton2") 
    @dal15 = @glade.get_widget("checkbutton3") 
    @dother = @glade.get_widget("checkbutton4") 
    @ticketb = @glade.get_widget("checkbutton6") 
    @toggle = @glade.get_widget("togglebutton1") 
    @newval = {}
    @g = General.new
    fill_tree_ticket
    filltrees
    clearall
    setPricegr
    setStyles
    setClientInfo
    setCashierName("#{getCashierName(@cs)}")
    @clockThread = Thread.new(@clockLabel) do |clockLabel|
    while true
         @clockl.text = Time.now.strftime("%I:%M%p")
         sleep(1)
    end
    end
  end

  def fill_tree_ticket
    @tree_ticket = @glade.get_widget("treeview1")
    @model = Gtk::ListStore.new(String, String, String, String)
    @renderer = Gtk::CellRendererText.new
    @tree_ticket.set_model(@model)
    @col1 = Gtk::TreeViewColumn.new("BARCODE", @renderer, {:text => 0})
    @col2 = Gtk::TreeViewColumn.new("QTY", @renderer, {:text => 1})
    @col3 = Gtk::TreeViewColumn.new("DESCRIPTION", @renderer, {:text => 2})
    @col4 = Gtk::TreeViewColumn.new("PRICE", @renderer, {:text => 3})
    @tree_ticket.append_column(@col1)
    @tree_ticket.append_column(@col2)
    @tree_ticket.append_column(@col3)
    @tree_ticket.append_column(@col4)
  end

  def filltrees
    @tree_hsale = @glade.get_widget("treeview3")
    @tree_search= @glade.get_widget("treeview4")
    @model2 = Gtk::ListStore.new(String, String, String, String)
    @model3 = Gtk::ListStore.new(String, String, String, String)
    @renderer2 = Gtk::CellRendererText.new
    @renderer3 = Gtk::CellRendererText.new
    @tree_hsale.set_model(@model2)
    @tree_search.set_model(@model3)
    @col11 = Gtk::TreeViewColumn.new("CLIENT", @renderer2, {:text => 0})
    @col22 = Gtk::TreeViewColumn.new("IDSALE", @renderer2, {:text => 1})
    @col33 = Gtk::TreeViewColumn.new("AMOUNT", @renderer2, {:text => 2})
    @col44 = Gtk::TreeViewColumn.new("TPAYMENT", @renderer2, {:text => 3})
    @tree_hsale.append_column(@col11)
    @tree_hsale.append_column(@col22)
    @tree_hsale.append_column(@col33)
    @tree_hsale.append_column(@col44)
    @cola = Gtk::TreeViewColumn.new("BARCODE", @renderer3, {:text => 0})
    @colb = Gtk::TreeViewColumn.new("DESCRIPTION", @renderer3, {:text => 1})
    @colc = Gtk::TreeViewColumn.new("PRICE", @renderer3, {:text => 2})
    @cold = Gtk::TreeViewColumn.new("QTY", @renderer3, {:text => 3})
    @tree_search.append_column(@cola)
    @tree_search.append_column(@colb)
    @tree_search.append_column(@colc)
    @tree_search.append_column(@cold)
    Gtk::Drag.source_set(@tree_ticket, Gdk::Window::BUTTON1_MASK | 
         Gdk::Window::BUTTON2_MASK,
         [["itemsold", Gtk::Drag::TARGET_SAME_APP, 12345]], 
         Gdk::DragContext::ACTION_COPY | 
         Gdk::DragContext::ACTION_MOVE)
    @tree_ticket.signal_connect("drag_data_get") do |widget, context, selection_data, info, time|
          selection_data.set(Gdk::Selection::TYPE_STRING, "itemssold")  
    end
    Gtk::Drag.dest_set(@trash_sale, Gtk::Drag::DEST_DEFAULT_MOTION | 
         Gtk::Drag::DEST_DEFAULT_HIGHLIGHT,
         [["itemsold", Gtk::Drag::TARGET_SAME_APP, 12345]], 
         Gdk::DragContext::ACTION_COPY|Gdk::DragContext::ACTION_MOVE)
 
    @trash_sale.signal_connect("drag-data-received") do |w, dc, x, y, selectiondata, info, time|
      dc.targets.each do |target|
        if target.name == "itemsold" ||
            selectiondata.type == Gdk::Selection::TYPE_STRING
            @dis = getdisc 
            @trash_sale.set("trashfull.xpm")
            @item.returnItem(@idv,@tree_ticket.selection.selected[0],@tree_ticket.selection.selected[1],@dis)
        end
      end
    end
    @trash_sale.signal_connect("drag-drop") do |w, dc, x, y, time|
        Gtk::Drag.get_data(w, dc, dc.targets[0], time)
    end
    
    Gtk::Drag.source_set(@tree_hsale, Gdk::Window::BUTTON1_MASK |
         Gdk::Window::BUTTON2_MASK,
         [["oldsales", Gtk::Drag::TARGET_SAME_APP, 12345]],
         Gdk::DragContext::ACTION_COPY |
         Gdk::DragContext::ACTION_MOVE)
    @tree_hsale.signal_connect("drag_data_get") do |widget, context, selection_data, info, time|
          selection_data.set(Gdk::Selection::TYPE_STRING, "oldsales")
    end
    Gtk::Drag.dest_set(@trash_osale, Gtk::Drag::DEST_DEFAULT_MOTION |
         Gtk::Drag::DEST_DEFAULT_HIGHLIGHT,
         [["oldsales", Gtk::Drag::TARGET_SAME_APP, 12345]],
         Gdk::DragContext::ACTION_COPY|Gdk::DragContext::ACTION_MOVE)

    @trash_osale.signal_connect("drag-data-received") do |w, dc, x, y, selectiondata, info, time|
      dc.targets.each do |target|
        if target.name == "oldsales" ||
            selectiondata.type == Gdk::Selection::TYPE_STRING
            @trash_osale.set("trashfull2.xpm")
            @item.returnSale(@tree_hsale.selection.selected[1])
        end
      end
    end
    @trash_osale.signal_connect("drag-drop") do |w, dc, x, y, time|
        Gtk::Drag.get_data(w, dc, dc.targets[0], time)
    end
     
  end

  def setStyles
    f = Gtk::Widget.default_style.font_desc.copy
    f.weight = Pango::FontDescription::WEIGHT_SEMIBOLD
    f.size = Pango::SCALE * 14 
    @mybus.modify_font(f)
    @chang.modify_font(f)
    f.weight = Pango::FontDescription::WEIGHT_BOLD
    @date.modify_font(f)
    f.size = Pango::SCALE * 24 
    @clockl.modify_font(f)
    f.weight = Pango::FontDescription::WEIGHT_ULTRABOLD
    f.size = Pango::SCALE * 44 
    @total.modify_font(f)
  end

  def fillitem(q,s,p,b)
    @q, @s, @p, @b = q, s, p, b
    @iter = @model.prepend
    @iter.set_value(0,@b.to_s)
    @iter.set_value(1,@q.to_s)
    @iter.set_value(2,@s.to_s)
    @iter.set_value(3,@p.to_s)
  end

  def fillsearch(i,d,p,q)
    @i, @d, @p, @q = i, d, p, q
    @iter = @model3.prepend
    @iter.set_value(0,@i.to_s)
    @iter.set_value(1,@d.to_s)
    @iter.set_value(2,@p.to_s)
    @iter.set_value(3,@q.to_s)
  end

  def removeitem
      @model.remove(@tree_ticket.selection.selected)
  end

  def removesale
      @model2.remove(@tree_hsale.selection.selected)
  end

  def fillsale(c,i,a,t)
    @iter = @model2.prepend
    @iter.set_value(0,c.to_s)
    @iter.set_value(1,i.to_s)
    @iter.set_value(2,a.to_s)
    @iter.set_value(3,t.to_s)
  end

  def getBarcode
     @entrybarcode.text
  end

  def setBarcode
    it = @tree_search.selection.selected[0]
    @entrybarcode.set_text("#{it}")
  end

  def getSearchItem
    @tree_search.selection.selected[0]
  end

  def getSearch
     @entrysearch.text
  end

  def getItemqty
    @entryqty.text.to_i
  end

  def getPricegr
    @entryprgr.text.to_f
  end

  def getQtygr
    @entryopprgr.text.to_f
  end

  def getClient
    @entryclient.text
  end

  def getClientName(idc)
    @idc  = idc
    @g.getClientName(@idc)
  end

  def getClientAddress(idc)
    @idc = idc
    @g.getClientAddress(@idc)
  end

  def getClientRFC(idc)
    @idc = idc
    @g.getClientRFC(@idc)
  end

  def getClientPoints(idc)
    @idc = idc
    @g.getClientPoints(@idc)
  end

  def getCashierName(id)
    @id = id
    @g.getCashierName(@id)
  end

  def setCashierName(cs)
    @cas = cs
    @cashier.set_text(@cas)
  end

  def setClientInfo
    setClientName
    setClientAddress
    setClientRFC
    setClientPoints
  end

  def setClientName
   @clientname.set_text("#{getClientName(getClient)}")
  end

  def setClientAddress
   @clientaddress.set_text("#{getClientAddress(getClient)}")
  end

  def setClientRFC
   @clientrfc.set_text("#{getClientRFC(getClient)}")
  end

  def setClientPoints
   @clientpoints.set_text("#{getClientPoints(getClient)}")
  end

  def getPayment
   @p = @entrypayment.text.to_f
   if @p == 0.0 then
      quickmessage("NO_PAYMENT")
      @entrypayment.grab_focus
      return @p 
   else
      return @p
   end
  end


  def get_total
     @total.text.to_f
  end

  def set_total(v)
    @v = v.to_s
    @total.set_text("#{@v}")
  end

  def getdisc
    if @dal5.active?
       @disc = 0.05
    elsif @dal10.active?
       @disc = 0.1
    elsif @dal15.active?
       @disc = 0.15
    elsif @dother.active?
       @disc = OTHERDISCOUNT
    else
       @disc = 0
    end
    return @disc
  end

  def getsaleid
     @vid.text
  end

  def getqitem
     @entryqty.text
  end

  def getqitemlabel
     @pq.text
  end

  def cancelall
   if (conf_message("ARE YOU SURE?") and (get_total > 0)) then
     @s = getsaleid
     @item.cancelall(@s)
   end
  end

  def setqitem(q)
     @q = q
     @pq.set_text("#{@q}")
  end

  def setsaleid
    @vid.set_text(@myreg.makeNewSale)
  end

  def setItem
    @entrypayment.set_text("00.00")
    @entryqty.set_text("1")
    @entryqty.select_region(0, -1)
    @entrybarcode.select_region(0, -1)
    @entrybarcode.grab_focus
  end

  def movetobarc
    @entrybarcode.grab_focus
  end

  def setPricegr
    @newval = {}
    @entryprgr.set_text("Price/Grain")
    @entryopprgr.set_text("Price/Grain")
  end

  def procItem 
    @barcode = getBarcode
    @qty = getItemqty
    @client = getClient
    unless getPricegr > 0 then
      @qpt += getqitem.to_i
    end
    @tot = get_total
    @idv = getsaleid
    @disc = getdisc 
    setqitem(@qpt)
    @item.procItem(@barcode,@qty,@client,@tot,@idv, @disc, @cs, @newval)
  end

  def findItem
    @search = getSearch
    @item.findItem(@search)
  end

  def calcchange
    if get_total > 0 then
      if !@toggle.active? then
       @change = getPayment - get_total
       if @change < 0 then
        quickmessage("PAYMENT_IS_LOWER_THAN_TOTAL")
       else
        @chang.set_text("#{@change}")
       end
      end
    else
       quickmessage("NO_ITEMS_FOUND")
    end
  end

  def procNewclient
   if get_total > 0 then
    if @toggle.active? then
      @cpayment = get_total
    else
      @cpayment = getPayment
    end
    @idt = getsaleid
    @client = getClient
    if @cpayment != 0.0 then
      if @tpaymentcash.active? 
       @myp = "Cash"
      elsif @tpaymentcredit.active? 
       @myp =  "Credit"
      elsif  @tpaymentdisc.active?
        @myp  =  "Promo"
        @di = getdisc
      elsif @tpaymenttcred.active?
       @myp =  "CreditCard"
      end
      @item.payItems(@idt,@cpayment,@client, @myp, @di)
      if @ticketb.active? then
         @myreg.printt(@idt,get_total,PRINTER)
      end
      clearall
    end
   else
    quickmessage("NO_ITEMS_FOUND")
    @entrypayment.set_text("00.00")
   end
  end

  def clearall
    @di = getdisc
    if @di != 0 then
      quickmessage("PLEASE_CLEAR_DISCOUNT_CHECKBOX")
    end
    @total.set_text("00.00")
    @entrybarcode.set_text("0000000000")
    @entrybarcode.select_region(0, -1)
    @entryclient.set_text("1")
    @entrypayment.set_text("00.00")
    @entryqty.select_region(0, -1)
    @entryqty.set_text("1")
    @pq.set_text("0")
    @qpt = 0
    @model.clear
    @trash_sale.set("trash.xpm")
    @trash_osale.set("trash2.xpm")
    @tpaymentcash.set_active("true")
    setClientInfo
    setsaleid
    setItem
    setPricegr
  end

  def clearsearch
    @model3.clear
    @entrysearch.set_text("")
  end

  def quickmessage(message)
    dialog = Gtk::Dialog.new("Message", $main_application_window, 
             Gtk::Dialog::DESTROY_WITH_PARENT, 
             [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])
    dialog.signal_connect('response') { dialog.destroy }
    dialog.vbox.add(Gtk::Label.new(message))
    dialog.vbox.add Gtk::Image.new("about/stop.xpm")
    dialog.show_all
 end

 def conf_message(str, default = true,type = Gtk::MessageDialog::QUESTION)
   qu = Gtk::MessageDialog.new(nil, Gtk::Dialog::MODAL,type,Gtk::MessageDialog::BUTTONS_YES_NO, str)
   if (default)
     qu.set_default_response(Gtk::MessageDialog::RESPONSE_YES)
   else
     qu.set_default_response(Gtk::MessageDialog::RESPONSE_NO)
   end
   qu.title = "Confirm"
   r = qu.run
   qu.destroy
   r == Gtk::Dialog::RESPONSE_YES
 end

 def granulargui(p,q)
  @p, @q = p,q
  @granul = Granular.new(@entryprgr,@entryopprgr, @p ,@q)  
 end

 def activeprgr
    @qty_gr  = getPricegr
    @price_gr= getQtygr 
    if @qty_gr > 0 then
      @newval = {"qty" => @qty_gr, "price" => @price_gr} 
    end
 end

 def focusbarcode
    @entrybarcode.grab_focus
 end

 def quit
  if (get_total > 0) then
   if conf_message("ARE YOU SURE?, TOTAL > 0.0")  then
     @s = getsaleid
     @item.cancelall(@s)
     @window.destroy
   end
  else
   @window.destroy
  end
 end
 
end

class Granular
  #include GetText

  attr :glade
  
  def initialize(widget1,widget2, pr, qty)
    @widg, @widg2, @pr, @qty = widget1, widget2 , pr, qty
    @glade = Gtk::UIManager.new
    @glade.add_ui("granular/granular.ui")
    #@glade = GladeXML.new("granular/granular.glade") {|handler| method(handler)}
    @gwindow= @glade["window1"]
    @radiog = @glade["radiobutton1"]
    @entry  = @glade["entry1"]
    @button  = @glade["button1"]
  end
  
  def fillgrains_price
     @g  = @entry.text.to_f 
     if @radiog.active? then
        @q = @g
        @p = @pr*@q 
     else
        @p = @g
        @q = @p/@pr
     end
     @widg.set_text(@q.to_s)
     @widg2.set_text(@p.to_s)
  end

  def move
    @entry.grab_focus
  end

  def movefill
    @button.grab_focus
    fillgrains_price
  end

  def quit
     @gwindow.hide
  end

end

