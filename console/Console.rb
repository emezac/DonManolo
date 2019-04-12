require 'PosModel.rb'
require 'PosView.rb'
require 'PosController.rb'
require 'lib/Register.rb'
require 'lib/General.rb'
require 'gtk2'


class AboutGlade
  #include GetText
  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = Gtk::UIManager.new
    @glade.add_ui("about/about.ui")
    
    @ab = @glade["about"]
    @ab.title = "About DonManolo"
  end
  
  def aboutq(widget, arg0)
    widget.destroy
  end

end

class Console

  def initialize(user)
    @user = user
    @glade = Gtk::UIManager.new
    @glade.add_ui("console/console.ui")
    @text = @glade["label1"]
    @g = General.new
  end
  
  def about
   AboutGlade.new("about/about.ui", nil, "DonManolo")
  end

  def pos
      @cashier     = @g.getCashierid(@user) 
      if @g.isCashier(@cashier)     then
         @itemch      = PosModel.new
         @register    = Register.new
         @pgui        = PosGUI.new(@register,@itemch,@cashier)
         watcher      = PosWatcher.new(@itemch,@pgui,@register)
      else
         quickmessage("ONLY FOR CASHIERS")
      end
  end 

  def checkout
    @register    = Register.new
    @register.checkout
    @text.set_text("Warehouse updated...")
  end

  def reports
    if @g.getUseradmin(@user) then
       @href = Gnome::HRef.new("http://localhost:3000/report", "admin")
    else
      quickmessage("ONLY FOR ADMINISTRATORS")
    end
  end

  def  uinventory
    if @g.getUseradmin(@user) then
      @register    = Register.new
      @register.updatei
      @text.set_text("Moving items purchased to inventory....")
      @text.set_text("Warehouse updated...")
    else
      quickmessage("ONLY FOR ADMINISTRATORS")
    end
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

  def quit
    Gtk.main_quit
  end

end

