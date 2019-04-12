class Client < ActiveRecord::Base
#  acts_as_reportable
  has_many :historicsales
end
