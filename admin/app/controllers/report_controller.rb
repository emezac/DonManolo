class ReportController < ApplicationController

  before_filter :authorize, :ensure_admin, :except => [:shopping_list, :shopping_list_byc, :shopping_list_byc_calc]

  def items_sold
     @historicsales = Historicsale.find(:all, :include => [:client, :item], :order => 'idsale DESC')
     @historicsales_pages, @historicsales = paginate :historicsales, :per_page => 8
  end

  def items_sold_bydate
     @hs = Hash.new
     @hidates = Historicsale.find(:all,:select => [:idsale], :group => 'idsale', :order => 'idsale DESC')
     @hidates.each {|d|
       @hs[d.idsale.to_date.strftime("%Y-%m-%d")] = d.idsale.to_date.strftime("%Y%m%d") 
     }
  end

  def items_sold_bydate_calc
    @tot = 0
    @par = params[:item][:item_id]  
    query ="select idsale,price,item_id,qty,client_id,cashier_id,total from historicsales WHERE idsale like '%" + params[:item][:item_id] + "%'" 
    @historicsales_byd = Historicsale.find_by_sql "#{query}"
    @historicsales_byd.each do |r|
      @tot += r.qty*r.price
    end
    @salescr = sales("creditpayments",params[:item][:item_id]) 
    @salescash = sales("cashpayments",params[:item][:item_id]) 
    @salespromo = sales("promopayments",params[:item][:item_id]) 
    @tot1 = 0
    @salescr.each do |r|
      @tot1 += r.amount.to_f
    end
    @tot2 = 0
    @salescash.each do |r|
      @tot2 += r.amount.to_f
    end
    @tot3 = 0
    @salespromo.each do |r|
      @tot3 += r.amount.to_f
    end
  end

  def items_sold_byitem
     @byitem=0
  end

  def items_sold_byitem_calc
    @tot = 0
    @para=Item.find(:first, :conditions => ["barcode = ?",params[:item][:item_id]]).description
    query ="select idsale,price,item_id,qty,client_id,cashier_id,total from historicsales WHERE item_id = " + params[:item][:item_id]
    @historicsales_byitem = Historicsale.find_by_sql "#{query}"
    @historicsales_byitem.each do |r|
      @tot += r.total
    end
    gsbyitem(params[:item][:item_id])    
  end

  def sales(type,id)
    query = "select distinct h.idsale, cr.amount,cl.name as client,e.name as cashier from historicsales h, #{type} cr,clients cl, employees e where h.idsale = cr.id and h.client_id = cl.id and e.id = h.cashier_id and h.idsale like '%#{id}%'"
    Historicsale.find_by_sql "#{query}"
  end

  def who_soldit
  end

  def whom_buy
  end

  def when_bought
  end

  def to_whom_bought
  end

  def inventoryv
  end

  def shopping_list
    @tot = 0
    @items = Item.find(:all, :conditions => ["minimum_stock > qty"])
    @items.each do |r|
      @tot += (r.minimum_stock-r.qty)*r.cost_price
    end
  end

  def shopping_list_byc
    query = "select distinct c.id, c.name from categories c, items i where i.category_id = c.id"
    @categories = Category.find_by_sql "#{query}" 
  end

  def shopping_list_byc_calc
    @para = Category.find(:first, :conditions => ["id = ?",params[:id]]).name
    @tot = 0
    query ="select description,cost_price,qty,minimum_stock,category_id from items WHERE minimum_stock > qty AND category_id = " + params[:id]  
    @items = Item.find_by_sql "#{query}"
    @items.each do |r|
      @tot += (r.minimum_stock-r.qty)*r.cost_price
    end
  end

  def shopping_performed
    @category_pages, @categories = paginate :categories, :per_page => 6
  end

  def shopping_performed_view
    query = "select i.description as description, h.barcode,h.price as price,h.cost_price,h.qty_purchased,h.expiration_date, h.date_purchased from historicpurchases h, items i, categories c where c.id = #{params[:id]} and c.id = i.category_id and i.barcode = h.barcode"
    @shops = Historicpurchase.find_by_sql "#{query}"
  end

  def gsbydate
   g = Gruff::Bar.new(700)
   g.title = "Sales by date" 
   g.font = File.expand_path('/public/fonts/VeraBd.ttf', RAILS_ROOT)
   g.labels = { 0 => 'Days' }
   @data = Sale.find(:all, :order => "idsale DESC", :limit => 5)
   @data.each do |d|
     g.data(d.idsale.to_date, d.total.to_f)
   end
   send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => "sbydate.png")
  end

  def gsbyitem(id)
   query ="select idsale,price,item_id,qty,client_id,cashier_id,total from historicsales WHERE item_id = " + id + " ORDER BY idsale DESC LIMIT 5"
   g = Gruff::Bar.new(400)
   g.theme = {
       :colors => ['#ff6600', '#3bb000', '#1e90ff', '#efba00', '#0aaafd'],
       :marker_color => '#aaa',
       :background_colors => ['#eaeaea', '#fff']
     }
   g.title = "Sales by item" 
   g.font = File.expand_path('/public/fonts/FreeSerif.ttf', RAILS_ROOT)
   ite = Item.find(:first, :conditions => ["barcode = ?", id]).description
   g.labels = { 0 => ite }
   @data = Historicsale.find_by_sql "#{query}"
   @data.each do |d|
     g.data(d.idsale.to_date, d.total.to_f)
   end
   g.write('public/images/sbyitem.png')
   #send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => "sbyitem.png")
  end

  def truncate(text, length = 30, end_string = '.')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end

  def allsales
   if params.size == 2
    url = '/report/allsales?Data'
    @graph = OpenFlashChart.swf_object(500, 500, url)
   else
    ofc = OpenFlashChart.new
    @ary = Array.new
    @ary2 = Array.new
    @data = Sale.sum :total, :limit => 20, :group => "idsale"
    ofc.title("SALES BY DATE", "{font-size: 20px;}")
    @data.each do |d|
       @ary << d[0].to_date.strftime("%Y-%m-%d")
       @ary2 << sprintf("%0.2f",d[1])
    end
    ofc.bar_filled(50, '#9933CC', '#8010A0', 'DAYS', 10)
    ofc.set_data(@ary2)
    ofc.set_x_labels(@ary)
    ofc.set_x_label_style(10, '#9933CC', 0, 2)
    ofc.set_x_axis_steps(2)
    ofc.set_y_max(1300)
    ofc.set_y_label_steps(3)
    ofc.set_y_legend(" Sales in $MX", 12, "#736AFF")
    render :text => ofc.render
   end
  end

  def best_item
   if params.size == 2
    url = '/report/best_item?Data'
    @graph = OpenFlashChart.swf_object(500, 500, url)
   else
    ofc = OpenFlashChart.new
    @ary = Array.new
    @ary2 = Array.new
    #@data = Historicsale.sum :total, :limit => 10,:group => :item_id, :order => :total
    query = "SELECT item_id, sum(total) as total FROM historicsales GROUP BY item_id ORDER BY sum( total ) DESC" 
    @data = Historicsale.find_by_sql "#{query}"
    ofc.title("BEST ITEM BY SALE", "{font-size: 20px;}")
    @data.each do |d|
       @ary << Item.find(:first,:conditions => ["barcode = ?",d["item_id"]]).description
       @ary2 << sprintf("%0.2f",d["total"])
    end
    ofc.bar_filled(50, '#9933CC', '#8010A0', 'ITEMS', 10)
    ofc.set_data(@ary2)
    ofc.set_x_labels(@ary)
    ofc.set_x_label_style(10, '#9933CC', 0, 2)
    ofc.set_x_axis_steps(2)
    ofc.set_y_max(1000)
    ofc.set_y_label_steps(3)
    ofc.set_y_legend(" Sales in $MX", 12, "#736AFF")
    render :text => ofc.render
   end
  end

  def bar_chart_glass
   if params.size == 2
    url = '/report/bar_chart_glass?Data'
    @graph = OpenFlashChart.swf_object(500, 500, url)
   else
    ofc = OpenFlashChart.new
    ofc.title("Glass BAR CHART FOR RUBY", "{font-size: 20px;}")
    ofc.set_data([1,2,3,4,5,6,7,8,9,10,11,12])
    ofc.bar_glass(50, '#9933CC', '#8010A0', 'PAGE VIEWS', 10)
    ofc.set_x_labels(%w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec))
    ofc.set_x_label_style(10, '#9933CC', 0, 2)
    ofc.set_x_axis_steps(2)
    ofc.set_y_max(15)
    ofc.set_y_label_steps(3)
    ofc.set_y_legend("Open flash chart for ruby", 12, "#736AFF")
    render :text => ofc.render  
   end
  end

  def multi_line
       if params.size == 2
          url = '/report/multi_line?Data'
          @graph = OpenFlashChart.swf_object( 500, 700, url)
       else
          ofc = OpenFlashChart.new
          ofc.title("MULTI LINE FOR RUBY", "{font-size: 25px;}")
          ofc.set_data((1..12).to_a.map{|x| x * 1.3})
          ofc.set_data((1..6).to_a + (1..6).to_a.reverse)
          ofc.set_data((1..2).to_a + (1..2).to_a.reverse + (3..8).to_a)
          ofc.line(2, '#9933CC', 'PAGE VIEWS', 12)
          ofc.line_dot(3,5,'0xCC3399', 'Downloads', 12)
          ofc.line_hollow(2,4,'0x80a033', 'Bounces', 12)
          ofc.set_x_labels(%w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec))
          ofc.set_x_label_style(12, '0x000000', 0, 2)
          ofc.set_y_max(12)
          ofc.set_y_label_steps(12)
          ofc.set_y_label_style(1, "#000000")
          ofc.set_y_legend("Open flash chart for ruby", 12, "#736AFF")
          render :text => ofc.render
       end
  end
end
