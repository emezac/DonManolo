#!/usr/bin/ruby

require 'gtk2'
require 'ProxyDb.rb'
require 'Console.rb'

class Login
  def initialize
    @glade = Gtk::UIManager.new
    @glade.add_ui("login/login.ui")
    @lwindow  = @glade["window1"]
    @username = @glade["entry1"]
    @password = @glade["entry2"]
    @lwindow.title = ("Login to DM Pos")
    @lwindow.set_window_position(Gtk::Window::POS_CENTER)
  end
  
  def checklogin
   usern = User.find(:first, :conditions => ["name = ?", @username.text])
   if usern then
      string_to_hash = @password.text.to_s + "wibble" + usern.salt
      if  usern.hashed_password == Digest::SHA1.hexdigest(string_to_hash) then
         Console.new(usern.id)
         @lwindow.hide
      else
         quickmessage("INCORRECT PASSWORD")
      end
   else
      quickmessage("INCORRECT USERNAME/PASSWORD")
   end
  end

  def change
    @password.grab_focus
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

def domain
window = Gtk::Window.new
window.signal_connect("delete_event"){ Gtk.main_quit; false }
image = Gtk::Image.new("about/logo.png")
th = Thread.new do
 sleep(3)
 window.hide
 @login = Login.new
end
window.add(image)
window.title = ("Don Manolo POS")
window.set_window_position(Gtk::Window::POS_CENTER)
window.show_all
end

Gtk.init
domain
Gtk.main
puts "Thank you for using our POS.........Bye......"

