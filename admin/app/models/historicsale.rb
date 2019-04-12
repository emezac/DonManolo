class Historicsale < ActiveRecord::Base
#  acts_as_reportable
  belongs_to :item
  belongs_to :client

  def client_name
    client.name
  end

  def item_name
    item.name
  end

end
