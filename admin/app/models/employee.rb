class Employee < ActiveRecord::Base
   belongs_to :store
   validates_presence_of :name, :store_id
end
