class HistoricsaleController < ApplicationController

  def tot_qty
     @qty = Historicsale.sum :qty
  end
end
