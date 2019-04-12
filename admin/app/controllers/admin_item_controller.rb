class AdminItemController < ApplicationController
  before_filter :authorize, :ensure_admin, :except => :new
 
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @item_pages, @items = paginate :items, :per_page => 6
  end


  def show
    @item = Item.find(params[:id])
    @item_aliases = ItemAlias.find(:all, :conditions => ["item_id = ?", params[:id]]) 
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def edit_alias
    @item_alias = ItemAlias.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item was successfully updated.'
      redirect_to :action => 'show', :id => @item
    else
      render :action => 'edit'
    end
  end

  def update_itemalias
    @item_alias = ItemAlias.find(params[:id])
    if @item_alias.update_attributes(params[:item_alias])
      flash[:notice] = 'ItemAlias was successfully updated.'
      redirect_to :action => 'show', :id => @item_alias.item_id
    else
      render :action => 'edit_alias'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def purchase
    @categories = Item.categories
  end

  def purchase_form
    @para = params[:id]
  end

  def purchase_exec
    @itemp = ItemPurchased.new(params[:itemp])
    if @itemp.save
      flash[:notice] = 'Item purchased was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'purchase'
    end
  end

  def do_search
    @phrase = params[:searchtext]
    a1 = "%"
    a2 = "%"
    @searchphrase = a1 + @phrase + a2
    @items = Item.search(@searchphrase)
    @number_match = @items.length
  end

end
