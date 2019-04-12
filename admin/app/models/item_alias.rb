class ItemAlias < ActiveRecord::Base
  belongs_to :item
  belongs_to :wmsystem

end
