#!/usr/bin/ruby

require 'lib/ProxyDb.rb'
#require 'libglade2'

class General


  def getClientName(id)
    @id = id
    c = Client.find(@id).name
    rescue ActiveRecord::RecordNotFound, "No record found"
  end

  def getClientAddress(id)
   @id = id
   c = Client.find(@id).address
   rescue ActiveRecord::RecordNotFound, "No record found"
  end

  def getClientRFC(id)
   @id = id
   c = Client.find(@id).taxid_rfc
   rescue ActiveRecord::RecordNotFound, "No record found"
  end

  def getClientPoints(id)
   @id = id
   c = Client.find(@id).points
   rescue ActiveRecord::RecordNotFound, "No record found"
  end

  def getCashierName(id)
   @id = id
   Employee.find(@id).name
  end

  def getCashierid(id)
    @id = id 
    e = Uemployee.find(:first, :conditions => ["id = ?",@id])
    if e then
      e.employee_id
    else
      return -1
    end
  end

  def isCashier(user)
    @user = user
    e = Employee.find(@user).cashier
    rescue ActiveRecord::RecordNotFound, "No record found"
  end

  def getUseradmin(adm)
    @adm = adm
    User.find(@adm).admin
  end

  def printt(idv,total,pr)
     st = Saletransaction.find(:all, :conditions => ["idsale = ?",idv])
     f = File.new("log/ticket.txt","w")
     f.printf "%10s\n",idv
     st.each {|line|
      f.printf "%10s,%10s,%10s,%10s\n",line.item,line.qty,line.price,line.total
     } 
     f.printf "%10s\n","------------------------"
     f.printf "%10s\n",total
     f.printf "%10s\n","Thank you !"
     f.close
     `lp -d #{pr} log/ticket.txt` 
  end

end
