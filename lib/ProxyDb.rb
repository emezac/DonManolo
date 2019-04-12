#!/usr/bin/ruby

require 'rubygems'
gem 'activerecord' ,'>= 1.15.2'
require 'active_record'


ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :database => "dmstore",
  :socket   => "/opt/lampp/var/mysql/mysql.sock",
  :username => 'root',
  :password => '',
  :host => 'localhost'
)

ActiveRecord::Base.logger = Logger.new(File.open('log/donmanolo.log', 'a')) 

class Item < ActiveRecord::Base
end

class Store < ActiveRecord::Base
end

class Saletransaction < ActiveRecord::Base
end

class Sale < ActiveRecord::Base
end

class Station < ActiveRecord::Base
end

class Client < ActiveRecord::Base
end

class Cashpayment < ActiveRecord::Base
end

class Creditpayment < ActiveRecord::Base
end

class Promopayment < ActiveRecord::Base
end

class Itemreturn < ActiveRecord::Base
end

class Salereturn < ActiveRecord::Base
end

class Employee < ActiveRecord::Base
end

class User < ActiveRecord::Base
end

class Historicsale < ActiveRecord::Base
end

class Uemployee < ActiveRecord::Base
end

class ItemPurchased < ActiveRecord::Base
end

class Historicpurchase < ActiveRecord::Base
end

class Category < ActiveRecord::Base
end

